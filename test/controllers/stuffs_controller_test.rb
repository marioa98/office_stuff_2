require 'test_helper'

class StuffsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    Category.create(category_name: Faker::Commerce.department)
    @category = Category.first

    password = Faker::Lorem.word
    @user = User.new(full_name: Faker::Name.name, email: Faker::Internet.email,username: Faker::Internet.username, password: @password)

    @user.save
    post '/login', params: {user: {username_or_email: @user.email, password: @password}}
  end
  
  test 'should GET #index' do
    get root_path

    assert_equal Stuff, assigns(:stuff)
    assert_response :success
  end

  test 'should create a new stuff request' do
    assert_difference('Stuff.count') do
      post new_stuff_path, params: { stuff: {category_id: @category.id, stuff_name: Faker::Commerce.material, user: @user}}
    end

    assert_redirected_to root_path
  end
end