require_relative '../../lib/fluent/mixin/ec2meta_placeholders/meta_fetcher'

module Ec2metaStub
  def stub_instance_id(instance_id)
    allow_any_instance_of(::Fluent::Mixin::Ec2metaPlaceholders::MetaFetcher).to \
      receive(:instance_id).and_return(instance_id)
  end

  def stub_vpc_id(vpc_id)
    allow_any_instance_of(::Fluent::Mixin::Ec2metaPlaceholders::MetaFetcher).to \
      receive(:vpc_id).and_return(vpc_id)
  end
end
