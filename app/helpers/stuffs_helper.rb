module StuffsHelper
  def categories(category_id)
    categories = []
    stuff_category = Category.find(@stuff.category_id).category_name
    
    categories << stuff_category
    Category.select(:category_name).where("category_name != ?", stuff_category).each do |category|
      # binding.pry
      categories << category.category_name
    end

    categories
  end

  def status(current_status)
    all_status = [current_status]

    Stuff.statuses.each do |status|
      all_status << status if status != current_status
    end
  end

  def filter_options
    ['All', 'Open', 'Fullfilled', 'Dismissed']
  end
end