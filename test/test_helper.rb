require 'simplecov'
require 'knapsack_pro'

SimpleCov.coverage_dir('public/coverage')
SimpleCov.start 'rails' do
  add_filter '/test/'
  add_filter '/config/'
  add_filter '/vendor/'
  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'  
end
ENV['RAILS_ENV'] ||= 'test'

knapsack_pro_adapter = KnapsackPro::Adapters::MinitestAdapter.bind
knapsack_pro_adapter.set_test_helper_path(__FILE__)