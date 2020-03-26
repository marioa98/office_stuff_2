ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
SimpleCov.coverage_dir('public/coverage')
SimpleCov.start 'rails' do
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/vendor/'
  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'  
end
