require 'fluent/config'
require 'ec2_meta'

module Fluent
  module Mixin
    module Ec2metaPlaceholders
      def replace(map, value)
        map.reduce(value) { |r, p| r.gsub(p[0], p[1].call) }
      end

      def replace_pattern?(value)
        value =~ /\$\{(?:vpc_id|instance_id:[a-z]+)\}/
      end

      def configure(conf)
        instance_id = conf['instance_id'] || fetch_instance_id
        vpc_id = conf['vpc_id'] || fetch_vpc_id || 'out_of_vpc'

        mapping = {
          '${vpc_id}'      => proc { vpc_id },
          '${instance_id}' => proc { instance_id }
        }

        def check_element(map, c)
          c.arg = replace(map, c.arg)
          c.keys.each do |k|
            v = c.fetch(k, nil)
            c[k] = replace(map, v) if v && v.is_a?(String)
          end
        end

        check_element(mapping, conf)

        super
      end

      private

      def fetcher
        return @fetcher if @fetcher

        @fetcher = Ec2Meta.client(
          fail_on_not_found: true
        )
      end

      def fetch_instance_id
        fetcher.instance_id
      end

      def fetch_vpc_id
        fetcher.network.interfaces.macs(0).vpc_id
      end
    end
  end
end
