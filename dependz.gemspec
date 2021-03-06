# frozen_string_literal: true

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2.4'
  s.name        = 'dependz'
  s.version     = '0.1.2'
  s.date        = '2020-09-17'
  s.summary     = 'ruby dependency management gem.'
  s.description = 'A ruby gem for concurrent tasks scheduling and resolving dependencies based on directed acyclic graphs and modified topological sorting algorithm.'
  s.authors     = ['Rundong Gao']
  s.email       = 'asphinx423@gmail.com'
  s.files       = Dir[
                   'lib/dependz/*.rb',
                   'lib/dependz.rb'
                  ]
  s.homepage    = 'https://github.com/RundongGao/depends'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rgl', '~> 0.5'
end
