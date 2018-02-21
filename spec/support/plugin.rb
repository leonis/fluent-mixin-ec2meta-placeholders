require 'fluent/input'

class Fluent::Ec2metaPlaceholdersTestNoConfigParamInput < Fluent::Input
  Fluent::Plugin.register_input('ec2meta_placeholders_test_no_config_param_input', self)

  attr_accessor :conf
  def configure(conf)
    super

    @conf = conf
  end
end

class Fluent::Ec2metaPlaceholdersTestDefaultInput < Fluent::Input
  Fluent::Plugin.register_input('ec2meta_placeholders_test_default_input', self)

  config_param :tag, :string
  config_param :path, :string

  include Fluent::Mixin::Ec2metaPlaceholders

  attr_accessor :conf
  def configure(conf)
    super

    @conf = conf
  end
end
