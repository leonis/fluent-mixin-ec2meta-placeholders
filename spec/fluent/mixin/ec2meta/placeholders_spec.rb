require 'spec_helper'

describe Fluent::Mixin::Ec2meta::Placeholders do
  it 'has a version number' do
    expect(Fluent::Mixin::Ec2meta::Placeholders::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
