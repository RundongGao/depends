# frozen_string_literal: true

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2.4'
  s.name        = 'depends'
  s.version     = '0.0.0'
  s.date        = '2020-09-17'
  s.summary     = ''
  s.description = ''
  s.authors     = ['Rundong Gao']
  s.email       = 'asphinx423@gmail.com'
  s.files       = ['lib/depends.rb']
  s.homepage    = 'https://rubygems.org/gems/depends'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rgl'

  s.add_development_dependency 'bundler'
end
