require 'spec_helper'

RSpec.describe Fluent::Mixin::Ec2metaPlaceholders do
  include Ec2metaStub

  before(:all) { Fluent::Test.setup }

  let(:instance_id) { 'idxxxxx' }
  let(:vpc_id) { 'vpc-yyyy' }

  let(:plugin) { driver.configure(conf).instance }

  before do
    stub_instance_id(instance_id)
    stub_vpc_id(vpc_id)
  end

  context 'with input plugin which has no config params' do
    let(:driver) do
      Fluent::Test::InputTestDriver.new(
        Fluent::Ec2metaPlaceholdersTestNoConfigParamInput
      )
    end

    context 'with non-placeholder config' do
      let(:conf) do
        %(
tag  SOME_TAG
path /path/to/some
        )
      end

      it 'does not use any config' do
        expect(plugin.conf.unused).to eq(%w[tag path])
        expect(plugin).not_to respond_to(:tag)
        expect(plugin).not_to respond_to(:path)
      end
    end

    context 'with placeholder config' do
      let(:conf) do
        %(
tag ${vpc_id}
path /archives/${vpc_id}/${instance_id}
        )
      end

      it 'does not use any config' do
        expect(plugin.conf.unused).to eq(%w[tag path])
        expect(plugin).not_to respond_to(:tag)
        expect(plugin).not_to respond_to(:path)
      end
    end
  end

  context 'with input plugin which has some config params' do
    let(:driver) do
      Fluent::Test::InputTestDriver.new(
        Fluent::Ec2metaPlaceholdersTestDefaultInput
      )
    end

    context 'with non-placeholder config' do
      let(:conf) do
        %(
tag  SOME_TAG
path /path/to/some
        )
      end

      it 'does not replace any configs' do
        expect(plugin.conf.unused).to be_empty
        expect(plugin.tag).to eq('SOME_TAG')
        expect(plugin.path).to eq('/path/to/some')
      end
    end

    context 'with placeholder config' do
      let(:conf) do
        %(
tag ${vpc_id}
path /archives/${vpc_id}/${instance_id}
        )
      end

      it 'replace placeholders with meta' do
        expect(plugin.tag).to eq(vpc_id)
        expect(plugin.path).to eq("/archives/#{vpc_id}/#{instance_id}")
      end
    end
  end
end
