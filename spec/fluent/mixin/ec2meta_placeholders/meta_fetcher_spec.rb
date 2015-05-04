require 'spec_helper'
require 'ec2_meta'

RSpec.describe Fluent::Mixin::Ec2metaPlaceholders::MetaFetcher do
  let(:fetcher) { Fluent::Mixin::Ec2metaPlaceholders::MetaFetcher.new }

  describe 'initialize' do
    it 'instanciate MetaFetcher' do
      expect(subject.instance_variable_get(:@fetcher)).to \
        be_an_instance_of(::Ec2Meta::Client)
    end
  end

  describe '#instance_id' do
    let(:instance_id) { 'id-xxxx' }
    subject { fetcher.instance_id }

    before do
      stub_request(
        :get,
        'http://169.254.169.254/2014-02-25/meta-data/instance-id'
      ).to_return(body: instance_id)
    end

    it { expect(subject).to eq(instance_id) }
  end

  describe '#vpc_id' do
    let(:vpc_id) { 'vpc-yyyy' }
    let(:mac_addr) { 'xx:xx:xx:xx' }
    subject { fetcher.vpc_id }

    before do
      stub_request(
        :get,
        'http://169.254.169.254/2014-02-25/meta-data/network/interfaces/macs/'
      ).to_return(body: mac_addr + "/\n")

      stub_request(
        :get,
        "http://169.254.169.254/2014-02-25/meta-data/network/interfaces/macs/#{mac_addr}/vpc-id"
      ).to_return(body: vpc_id)
    end

    it { expect(subject).to eq(vpc_id) }
  end
end
