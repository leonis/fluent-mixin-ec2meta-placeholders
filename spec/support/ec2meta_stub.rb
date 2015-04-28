module Ec2metaStub
  def stub_instance_id(instance_id)
    allow_any_instance_of(::Ec2Meta::Client).to \
      receive(:instance_id).and_return(instance_id)
  end

  def stub_vpc_id(vpc_id)
    allow_any_instance_of(::Ec2Meta::Client).to \
      receive_message_chain(:network, :interfaces, :macs, :vpc_id).and_return(vpc_id)
  end
end
