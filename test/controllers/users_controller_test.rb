require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @password = Faker::Lorem.word 

    @user = User.new(
      full_name: Faker::Name.name,
      username: Faker::Internet.username,
      email: Faker::Internet.email,
      password: @password
    )

    @user_2 = User.new(
      full_name: Faker::Name.name,
      username: Faker::Internet.username,
      email: Faker::Internet.email,
      password: @password
    )
  end

  test 'shoud GET #new' do
    get '/signin'

    assert_kind_of User, assigns(:user)
    assert_response :success
  end

  test 'should POST #create' do  
    post '/signin', params: { user: @user.attributes }
    assert_response :success
  end

  test 'should not POST #create' do
    @user.email = ''
    post '/signin', params: {user: @user.attributes}
    assert_template 'new'
  end

  test 'should convert user to admin' do
    post '/login', params: {user: {username_or_email: @user.email, password: @password}}
    @user.admin = true

    post to_admin_path, params: {id: @user_2.id}
    
    assert_response :success
    assert_redirected_to users_index_path
  end
  # test 'should GET #profile' do
  #   @user.save
  #   get '/profile', params: {session: {user_id: @user.id}}
  #   assert_response :found
  # end

  # test 'should UPDATE #profile' do
  #   @user.save 
  #   @user.email = Faker::Internet.email
  #   post '/profile', params: {session: {user_id: @user.id}, user: @user.attributes}
    
  #   assert_redirected_to my_profile_path
  #   assert_select flash[:notice], "Profile updated successfully"
  # end
end