require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(
      full_name: Faker::Name.name,
      username: Faker::Internet.unique.username,
      email: Faker::Internet.unique.email,
      password: Faker::Lorem.word
    )
  end

  test 'valid common user ' do
    assert @user.valid?
  end

  test 'valid admin user' do
    @user.admin = true
    assert @user.valid?
  end

  test 'invalid user with nil full name' do
    @user.full_name = nil
    assert_not @user.valid?
  end

  test 'invalid user full name with empty string' do
    @user.full_name = ''
    assert_not @user.valid?
  end

  test 'invalid user with nil username' do
    @user.username = nil
    assert_not @user.valid?
  end

  test 'invalid user username with empty string' do
    @user.username = ''
    assert_not @user.valid?
  end

  test 'invalid user with nil password' do
    @user.password = nil
    assert_not @user.valid?
  end

  test 'invalid user with nil email' do
    @user.email = nil
    assert_not @user.valid?
  end

  test 'invalid email with empty string email' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'invalid user with invalid email format' do
    @user.email = Faker::Lorem.word
    assert_not @user.valid?
  end

  test 'invalid user with repeated username' do
    user_2 = User.new(@user.attributes)

    assert_not user_2.valid?
  end
end