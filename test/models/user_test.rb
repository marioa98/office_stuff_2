require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid common user ' do
    user = User.new(full_name: Faker::Name.name, username: Faker::Internet.username, password: Faker::Lorem.word)
    assert user.valid?
  end

  test 'valid admin user' do
    user = User.new(full_name: Faker::Name.name, username: Faker::Internet.username, password: Faker::Lorem.word, admin: true)
    assert user.valid?
  end

  test 'invalid user with nil full name' do
    user = User.new(username: Faker::Internet.username, password: Faker::Lorem.word)
    assert_not user.valid?
  end

  test 'invalid user full name with empty string' do
    user = User.new(full_name: "", username: Faker::Internet.username, password: Faker::Lorem.word)
    assert_not user.valid?
  end

  test 'invalid user with nil username' do
    user = User.new(full_name: Faker::Name.name, password: Faker::Lorem.word)
    assert_not user.valid?
  end

  test 'invalid user username with empty string' do
    user = User.new(full_name: Faker::Name.name, username: "", password: Faker::Lorem.word)
    assert_not user.valid?
  end

  test 'invalid user with nil password' do
    user = User.new(full_name: Faker::Name.name, username: Faker::Internet.username)
    assert_not user.valid?
  end
  
  test 'invalid user password with empty string' do
    user = User.new(full_name: Faker::Name.name, username: Faker::Internet.username, password: "")
    assert_not user.valid?
  end

  test 'invalid user with repeated username' do
    user = User.new(full_name: Faker::Name.name, username: Faker::Internet.username, password: Faker::Lorem.word)
    user.save
    user_2 = User.new(user.attributes)

    assert_not user_2.valid?
  end
end