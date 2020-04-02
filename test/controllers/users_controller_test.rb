require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @password = Faker::Lorem.word 

    @user = User.new(
      full_name: Faker::Name.name,
      username: Faker::Internet.unique.username,
      email: Faker::Internet.unique.email,
      password: @password
    )

    @user_2 = User.new(
      full_name: Faker::Name.name,
      username: Faker::Internet.unique.username,
      email: Faker::Internet.unique.email,
      password: @password
    )
  end

  test 'shoud GET #new' do
    get '/signin'

    assert_kind_of User, assigns(:user)
    assert_response :success
  end

  test 'should POST #create' do  
    post '/signin', params: { user: {full_name: @user.full_name, username: @user.username, email: @user.email, password: @password}}
    @user = User.find_by(email: @user.email)

    assert_equal @user.id, session[:user_id]
    assert_redirected_to root_path
  end

  test 'should not POST #create' do
    @user.email = ''
    post '/signin', params: {user: @user.attributes}
    assert_template 'new'
  end

  test 'should convert user to admin' do
    @user.save
    User.find(@user.id).update(admin: true)
    post '/login', params: {user: {username_or_email: @user.email, password: @password}}

    @user_2.save
    post "/users/#{@user_2.id}"
    
    assert_redirected_to users_index_path
  end
  
  test 'should GET #profile' do
    @user.save
    post '/login', params: {user: {username_or_email: @user.email, password: @password}}

    get '/profile', params: {session: {user_id: @user.id}}
    assert_kind_of User, assigns(:user)
  end

  test 'should UPDATE #profile' do
    @user.save
    post '/login', params: {user: {username_or_email: @user.email, password: @password}}

    @user.email = Faker::Internet.email
    post '/profile', params: {session: {user_id: @user.id}, user: @user.attributes}

    assert_equal "Profile updated successfully", flash[:notice]
    assert_redirected_to my_profile_path
  end

  test 'should not UPDATE #profile' do
    @user.save
    post '/login', params: {user: {username_or_email: @user.email, password: @password}}

    @user.email = Faker::Lorem.word
    post '/profile', params: {session: {user_id: @user.id}, user: @user.attributes}

    assert_template 'profile'
  end

  test 'should GET #index' do
    @user.save
    post '/login', params: {user: {username_or_email: @user.email, password: @password}}

    get '/users'
    user = assigns(:common_users).first

    assert_kind_of User, user if user.present?
    assert_response :success
  end
end