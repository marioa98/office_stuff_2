require 'test_helper' 

class StuffTest < ActiveSupport::TestCase
  def setup 
   category = Category.create(category_name: Faker::Commerce.department)
   user = User.create(full_name: Faker::Name.name, username: Faker::Internet.username, password: Faker::Lorem.word)
   @stuff = Stuff.new(
      user: user, 
      category: category,
      stuff_name: Faker::Name.name
    )
  end

  test 'validates stuff with valid params' do
    assert @stuff.valid?
  end

  test 'validates stuff without params' do
    @stuff = Stuff.new
    assert_not @stuff.valid?
  end
  
  test 'validates stuff without stuff_name' do
    @stuff.stuff_name = ''
    assert_not @stuff.valid?
  end

  test 'default status is open' do 
    assert @stuff.open? 
  end

  test 'validates stuff is saved without user_id' do
    @stuff.user_id = ''
    assert_not @stuff.valid? 
  end  
  
  test 'validates stuff is saved without category_id' do
    @stuff.category_id = ''
    assert_not @stuff.valid?
  end
end