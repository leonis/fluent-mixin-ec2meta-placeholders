lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'fluent-mixin-ec2meta-placeholders'
  spec.version       = '0.0.1'
  spec.authors       = ['Daisuke Hirakiuchi']
  spec.email         = ['devops@leonisand.co']

  spec.summary       = 'Placeholders about ec2 metadata for fluentd plugin configuration'
  spec.description   = 'Configuration syntax extension mixin for fluentd plugin'
  spec.homepage      = 'https://github.org/leonis/fluent-mixin-ec2meta-placeholders'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_dependency 'fluentd', '~> 0.14'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0.0'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'rubocop', '~> 0.52'
  spec.add_development_dependency 'test-unit', '~> 3.2'
end
