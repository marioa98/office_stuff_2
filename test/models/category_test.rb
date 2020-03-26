require 'test_helper'
class CategoryTest < ActiveSupport::TestCase
  test 'valid category name' do
    category = Category.new(category_name: 'Computer stuff')
    assert category.valid?
  end

  test 'invalid category without name argument' do
    category = Category.new
    assert_not category.valid?
  end

  test 'invalid category with empty string' do
    category = Category.new(category_name: "")
    assert_not category.valid?
  end

  test 'category name is not duplicated' do
    category = Category.create(category_name: "Computer")
    duplicated = Category.new(category_name: "Computer")
    assert_not duplicated.valid?
  end 
end