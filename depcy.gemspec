# frozen_string_literal: true

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2.4'
  s.name        = 'depcy'
  s.version     = '0.0.1'
  s.date        = '2020-09-17'
  s.summary     = 'ruby dependency management gem.'
  s.description = "Store dependencies in a graph struct, and sort them in topological order. No dpends_by will come be before it's depends_on."
  s.authors     = ['Rundong Gao']
  s.email       = 'asphinx423@gmail.com'
  s.files       = ['lib/depcy.rb']
  s.homepage    = 'https://github.com/RundongGao/dependz'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rgl', '~> 0.5'
end
