require 'test_helper'

class StuffsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @category = Category.first.valid? ? Category.first : Category.create(category_name: Faker::Commerce.unique.department)

    password = Faker::Lorem.word
    @user = User.new(
      full_name: Faker::Name.name, 
      email: Faker::Internet.unique.email,
      username: Faker::Internet.unique.username, 
      password: password
    )

    @user.save
    @stuff = Stuff.new(user: @user, category: @category, stuff_name: Faker::Commerce.unique.material)
    post '/login', params: {user: {username_or_email: @user.email, password: password}}
  end
  
  test 'should GET default #index' do
    get root_path

    stuff = assigns(:stuff).first
    
    assert_kind_of Stuff, stuff if stuff.present?
    assert_response :success
  end

  test 'should GET #index with all categories and all status' do
    get root_path, params: {filter: {status: 'All', category: 'All'}}

    stuff = assigns(:stuff).first
    
    assert_kind_of Stuff, stuff if stuff.present?
    assert_response :success
  end

  test 'should GET #index with specific category and all status' do
    get root_path, params: {filter: {status: 'All', category: @category.category_name}}

    stuff = assigns(:stuff).first
    
    assert_kind_of Stuff, stuff if stuff.present?
    assert_response :success
  end

  test 'should GET #index with all categories and specific status' do
    get root_path, params: {filter: {status: 'Open', category: 'All'}}

    stuff = assigns(:stuff).first
    
    assert_kind_of Stuff, stuff if stuff.present?
    assert_response :success
  end

  test 'should GET #index with specific category and specific status' do
    get root_path, params: {filter: {status: 'Open', category: @category.category_name}}

    stuff = assigns(:stuff).first
    
    assert_kind_of Stuff, stuff if stuff.present?
    assert_response :success
  end

  test 'should GET /new_stuff' do
    get '/new_stuff'
    categories = assigns(:categories).first

    assert_kind_of Stuff, assigns(:stuff)
    assert_instance_of Category, categories if categories.present?

    assert_response :success
  end

  test 'should POST a new stuff request' do
    assert_difference('Stuff.count') do
      post new_stuff_path, params: { stuff: {category_id: @category.id, stuff_name: Faker::Commerce.material}, session: {user_id: @user.id}}
    end

    assert_redirected_to root_path
  end

  test 'should not POST a new stuff' do
    post new_stuff_path, params: { stuff: {category_id: @category.id, stuff_name: nil}, session: {user_id: @user.id}}

    assert_equal 'Please add the stuff name before to request.', flash[:alert]
    assert_redirected_to new_stuff_path
  end

  test 'should GET details of stuff' do
    @stuff.save unless  Stuff.first.present?
    stuff = Stuff.first
    get "/details/#{stuff.id}"

    assert_kind_of Stuff, assigns(:stuff)
    assert_response :success
  end

  test 'should GET edit_stuff_path' do
    @stuff.save unless  Stuff.first.present?
    stuff = Stuff.first
    get "/edit/#{stuff.id}"

    assert_kind_of Stuff, assigns(:stuff)
    assert_response :success
  end

  test 'should UPDATE new stuff' do
    @stuff.save unless  Stuff.first.present?
    stuff = Stuff.first
    Stuff.first.update(status: 0)

    patch "/edit/#{stuff.id}", params: {stuff: {status: '1'}}

    assert_kind_of Stuff, assigns(:stuff)
    assert_redirected_to root_path
  end
end