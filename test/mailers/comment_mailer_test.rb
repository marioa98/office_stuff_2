require 'test_helper'

class CommentMailerTest < ActionMailer::TestCase
  def setup
    password = Faker::Lorem.word
    @user = User.new(
      full_name: Faker::Name.name,
      email: Faker::Internet.email,
      username: Faker::Internet.username,
      password: password
    )

    @user_2 = User.new(
      full_name: Faker::Name.name,
      email: Faker::Internet.email,
      username: Faker::Internet.username,
      password: password
    )

    category = Category.first.present? ? Category.first : Category.create(category_name: Faker::Commerce.department)

    @user.save
    @user_2.save

    @stuff = Stuff.new(
      category: category,
      user: @user,
      stuff_name: Faker::Commerce.material
    )

    @stuff.save
  end

  test 'new comment' do
    comment = Comment.create(
      user: @user_2,
      stuff: @stuff,
      comment: Faker::Lorem.sentence
    )

    email = CommentMailer.with(stuff: @stuff, content: comment).new_comment

    assert_emails 1 do
      email.deliver_later
    end

    assert_equal ['noreply_office@stuff.com'], email.from
    assert_equal [@user.email], email.to
    assert_equal "Your stuff '#{@stuff.stuff_name}', has been commented", email.subject
  end

  test 'same stuff commented' do
    comment = Comment.create(
      user: @user,
      stuff: @stuff,
      comment: Faker::Lorem.sentence
    )

    comment_2 = Comment.create(
      user: @user_2,
      stuff: @stuff,
      comment: Faker::Lorem.sentence
    )

    recipients = extract_recipients(@user_2)
    email = CommentMailer.with(stuff: @stuff, recipients: recipients, content: comment).same_stuff_commented

    assert_emails 1 do
      email.deliver_later
    end

    assert_equal ['noreply_office@stuff.com'], email.from
    assert_equal recipients, email.to
    assert_equal "New comment in stuff '#{@stuff.stuff_name}'", email.subject
  end

  private 

  def extract_recipients(current_user)
    commenters = Comment.where("stuff_id = ? AND user_id != ?", @stuff.id, current_user.id).distinct.pluck(:user_id)

    recipients = []
    commenters.each do |user_id|
      user = User.find(user_id)
      recipients << user.email
    end

    recipients
  end
end