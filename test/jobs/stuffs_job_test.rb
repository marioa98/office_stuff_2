require 'test_helper'

class StuffsJobTest < ActiveJob::TestCase
  def setup
    password = Faker::Lorem.word
    @common = User.new(
      full_name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      username: Faker::Internet.unique.username,
      password: password
    )

    @admin = User.new(
      full_name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      username: Faker::Internet.unique.username,
      password: password,
      admin: true
    )

    @category = Category.first.valid? ? Category.first : Category.create(category_name: Faker::Commerce.unique.department)

    @common.save
    @admin.save
  end

  test 'New stuff requested' do
    stuff = Stuff.create(
      user: @common,
      category: @category,
      stuff_name: Faker::Commerce.material
    )

    assert_enqueued_jobs 1, queue: 'default' do
      StuffsJob.perform_later(stuff, 'create')
    end
  end
end