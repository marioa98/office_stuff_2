require 'test_helper'

class CommentsJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper
  def setup
    category = Category.first.valid? ? Category.first : Category.create(category_name: Faker::Commerce.department)
    password = Faker::Lorem.word
    @owner = User.new(
      full_name: Faker::Name.name,
      email: Faker::Internet.email,
      username: Faker::Internet.username,
      password: password
    )

    @commenter = User.new(
      full_name: Faker::Name.name,
      email: Faker::Internet.email,
      username: Faker::Internet.username,
      password: password
    )

    @stuff = Stuff.new(
      user: @owner,
      category: category,
      stuff_name: Faker::Commerce.material
    )

    @owner.save
    @commenter.save
    @stuff.save
  end

  test 'Email just for new comment' do
    comment = Comment.create(
      user: @commenter,
      stuff: @stuff,
      comment: Faker::Lorem.sentence
    )
    recipients = extract_recipients(@commenter)
    
    assert_enqueued_jobs 1, queue: 'default' do
      CommentsJob.perform_later(@stuff, recipients, comment, @commenter.id)
    end
  end

  private
  def extract_recipients(current_commenter)
    commenters = Comment.where("stuff_id = ? AND user_id != ?", @stuff.id, current_commenter.id).distinct.pluck(:user_id)

    recipients = []
    commenters.each do |user_id|
      user = User.find(user_id)
      recipients << user.email
    end

    recipients
  end
end