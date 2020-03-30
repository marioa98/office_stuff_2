require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.new(
      full_name: Faker::Name.name,
      username: Faker::Internet.username,
      email: Faker::Internet.email,
      password: Faker::Lorem.word
    )
  end

  test 'shoud GET #new' do
    get '/signin'
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

  test 'should GET #profile' do
    @user.save
    get '/profile', params: {session: {user_id: @user.id}}
    assert_response :found
  end

  test 'should UPDATE #profile' do
    @user.save 
    @user.email = Faker::Internet.email
    post '/profile', params: {session: {user_id: @user.id}, user: @user.attributes}
    
    assert_redirected_to my_profile_path
    assert_select flash[:notice], "Profile updated successfully"
  end
end