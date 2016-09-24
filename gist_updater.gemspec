# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gist_updater/version'

Gem::Specification.new do |spec|
  spec.name          = 'gist_updater'
  spec.version       = GistUpdater::VERSION
  spec.authors       = ['Takashi Masuda']
  spec.email         = ['masutaka.net@gmail.com']

  spec.summary       = 'Updates your Gist files'
  spec.description   = 'Updates your Gist files which defined in YAML file'
  spec.homepage      = 'https://github.com/masutaka/gist_updater'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'octokit', '~> 4.0'
  spec.add_dependency 'thor', '~> 0.19.1'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.43.0'
end
