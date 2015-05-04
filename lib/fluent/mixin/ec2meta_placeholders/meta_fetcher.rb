module Fluent
  module Mixin
    module Ec2metaPlaceholders
      class MetaFetcher
        def initialize(options = {})
          require 'ec2_meta'
          @fetcher = Ec2Meta.client(options)
        end

        def instance_id
          @fetcher.meta_data.instance_id
        end

        def vpc_id
          @fetcher.meta_data.network.interfaces.macs(0).vpc_id
        end
      end
    end
  end
end
