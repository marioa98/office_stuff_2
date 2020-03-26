require 'test_helper'

class StuffsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    Category.create(category_name: Faker::Commerce.department)
    User.create(
      full_name: Faker::Name.name,
      username: Faker::Internet.username,
      password: Faker::Lorem.word
    )
    
    @user = User.first
    @category = Category.first
    
    Stuff.create(category_id: @category.id, stuff_name: Faker::Commerce.material, user_id: @user.id)
  end
  
  test 'should GET #index' do
    get root_path
    assert_response :success
  end

  test 'should GET #index with all categories and all status' do
    get root_path, params: { filter: {status: 'All', category: 'All'}}
    assert_response :success
  end

  test "should GET #index with all categories and status specific status " do
    get root_path, params: { filter: {status: 'Open', category: 'All'}}
    assert_response :success
  end

  test "should GET #index with specific category and status 'open' " do
    get root_path, params: { filter: {status: 'All', category: @category}}
    assert_response :success
  end

  test "should GET #index with specific category and specific status" do
    get root_path, params: { filter: {status: 'Open', category: @category}}
    assert_response :success
  end

  test 'should create a new stuff request' do
    assert_difference('Stuff.count') do
      post new_stuff_path, params: { stuff: {category_id: @category.id, stuff_name: Faker::Commerce.material}}
    end

    assert_redirected_to root_path
  end

  test 'should update a current stuff request' do
    stuff = Stuff.first
    patch update_stuff_path(stuff), params: {stuff: {status: rand(1..2), stuff_name: Faker::Commerce.material, category_id: @category.id}}
    assert_response :found
    assert_redirected_to root_path
  end
end