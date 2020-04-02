require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @password = Faker::Lorem.word
    @user = User.new(full_name: Faker::Name.name, email: Faker::Internet.unique.email,username: Faker::Internet.unique.username, password: @password)

    @user.save
  end

  test 'should GET new User instance' do
    get '/login'
    assert_kind_of User, assigns(:user)
  end

  test 'should login successfully' do
    post '/login', params: {user: {username_or_email: @user.email, password: @password}}
    assert_redirected_to root_path
  end

  test 'should not login' do
    post '/login', params: {user: {username_or_email: @user.email, password: Faker::Lorem.word}}
    
    assert_equal "Username or password invalid. Please fill correctly", flash[:alert]
    assert_template :new
  end

  test 'should logout' do
    post '/login', params: {user: {username_or_email: @user.email, password: @password}}

    delete '/logout'
    assert_equal nil, assigns(:user)
    assert_redirected_to root_path
  end
end