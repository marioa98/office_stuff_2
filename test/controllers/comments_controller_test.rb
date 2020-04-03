require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @password = Faker::Lorem.word
    @user = User.new(full_name: Faker::Name.name, email: Faker::Internet.unique.email,username: Faker::Internet.unique.username, password: @password)
    category = Category.first.present? ? Category.first : Category.create(category_name: Faker::Commerce.unique.department)
    @stuff = Stuff.new(user: @user, category: category, stuff_name: Faker::Lorem.unique.word)

    @user.save
    @stuff.save

    post '/login', params: {user: {username_or_email: @user.email, password: @password}}
    assert_redirected_to root_path
  end
  
  test 'should get the comments route for a stuff' do
    get "/comments/#{@stuff.id}"
    assert_response :success
  end
  
  test 'should create a comment for a stuff' do
    assert_difference("Comment.all.where(stuff_id: #{@stuff.id}).count") do
      post create_comment_path(@stuff.id), params: { comment: { comment: Faker::Lorem.sentence}}
    end
    assert_redirected_to comments_index_path(@stuff.id)
  end

  test 'shoul get error creating a comment' do
    post create_comment_path(@stuff.id), params: {comment: {comment: nil}}
    assert_equal 'Comments cannot be blank', flash[:alert]
    assert_redirected_to comments_index_path(@stuff.id)
  end
end