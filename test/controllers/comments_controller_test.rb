require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    User.create(full_name: Faker::Name.name, username: Faker::Internet.username, password: Faker::Lorem.word)
    Category.create(category_name: Faker::Commerce.department)

    @user = User.first
    category = Category.first
    Stuff.create(user_id: @user.id, category_id: category.id, stuff_name: Faker::Commerce.material)
    @stuff = Stuff.first
  end

  test 'should get the comments route for a stuff' do
    get comments_index_path(@stuff.id)
    assert_response :success
  end

  test 'should create a comment for a stuff' do
    assert_difference("Comment.all.where(stuff_id: #{@stuff.id}).count") do
      post create_comment_path(@stuff.id), params: { comment: { comment: Faker::Lorem.sentence}}
    end
    assert_redirected_to comments_index_path(@stuff.id)
  end
end