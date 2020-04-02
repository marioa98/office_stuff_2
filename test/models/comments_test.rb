require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    category = Category.first.valid? ? Category.first : Category.create(category_name: Faker::Commerce.unique.department)
    @user = User.new(
      full_name: Faker::Name.name, 
      username: Faker::Internet.unique.username, 
      email: Faker::Internet.unique.email,
      password: Faker::Lorem.word
    )
    @stuff = Stuff.new(user: @user, category: category, stuff_name: Faker::Name.name)
  end
  
  test 'comment with valid parameters' do
    comment = Comment.new(user: @user, stuff: @stuff, comment: Faker::Lorem.sentence)

    assert comment.valid?
  end

  test 'invalid comment without user' do
    comment = Comment.new(stuff: @stuff, comment: Faker::Lorem.sentence)

    assert_not comment.valid?
  end

  test 'invalid comment without stuff' do
    comment = Comment.new(user: @user, comment: Faker::Lorem.sentence)

    assert_not comment.valid?
  end

  test 'invalid comment without content' do
    comment = Comment.new(user: @user, stuff: @stuff)

    assert_not comment.valid?
  end

  test 'invalid comment with empty string in comment' do
    comment = Comment.new(user: @user, stuff: @stuff, comment: '')

    assert_not comment.valid?
  end
end
