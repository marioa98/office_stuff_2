require 'test_helper'

class StuffMailerTest < ActionMailer::TestCase
  def setup
    @admin = User.new(
      full_name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      username: Faker::Internet.unique.username,
      password: Faker::Lorem.word,
      admin: true
    )

    @common = User.new(
      full_name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      username: Faker::Internet.unique.username,
      password: Faker::Lorem.word
    )

    category = Category.first.present? ? Category.first : Category.create(category_name: Faker::Commerce.unique.department)
    
    @admin.save
    @common.save

    @stuff = Stuff.new(
      category: category,
      user: @common,
      stuff_name: Faker::Commerce.unique.material
    )
  end

  test 'new request' do
    admins = extract_admins
    @stuff.save

    email = StuffMailer.with(stuff: @stuff).new_request

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['noreply_office@stuff.com'], email.from
    assert_equal admins, email.to
    assert_equal "New stuff request", email.subject
  end

  test 'set status' do
    @stuff.save
    Stuff.find(@stuff.id).update(status: 1)
    email = StuffMailer.with(stuff: @stuff).set_status

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['noreply_office@stuff.com'], email.from
    assert_equal [@stuff.user.email], email.to
    assert_equal "Status change in '#{@stuff.stuff_name}'", email.subject
  end

  private 

  def extract_admins
    User.where(admin: true).pluck(:email)
  end
end