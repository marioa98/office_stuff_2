require 'test_helper' 

class StuffTest < ActiveSupport::TestCase
  def setup 
    @category = Category.first.present? ? Category.first : Category.create(category_name: Faker::Commerce.unique.department)
    @user = User.new(full_name: Faker::Name.name, username: Faker::Internet.unique.username, password: Faker::Lorem.word, email: Faker::Internet.unique.email)
    @stuff = Stuff.new(
      stuff_name: Faker::Lorem.unique.word
    )
  end

  test 'validates stuff with valid params' do
    @stuff.user = @user
    @stuff.category = @category
    assert @stuff.valid?
  end

  test 'validates stuff without params' do
    stuff = Stuff.new
    assert_not stuff.valid?
  end
  
  test 'validates stuff without stuff_name' do
    @stuff.stuff_name = ''
    assert_not @stuff.valid?
  end

  test 'default status is open' do 
    assert @stuff.open? 
  end

  test 'validates stuff is saved without user' do
    @stuff.category = @category 
    assert_not @stuff.valid? 
  end  
  
  test 'validates stuff is saved without category' do
    @stuff.user = @user
    assert_not @stuff.valid?
  end
end