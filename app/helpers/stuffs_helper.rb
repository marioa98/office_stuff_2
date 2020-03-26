module StuffsHelper
  def categories(category_id)
    categories = []
    stuff_category = Category.find(@stuff.category_id)
    
    categories << stuff_category
    Category.where("category_name != ?", stuff_category).each do |category|
      categories << category
    end

    categories
  end

  def status(current_status)
    all_status = [current_status]

    Stuff.statuses.each do |status|
      all_status << status if status != current_status
    end
  end

  def categories_options
    options = ['All']
    
    Category.all.order(category_name: :asc).each do |category|
      options << category.category_name
    end

    options
  end

  def status_options
    ['All', 'Open', 'Fullfilled', 'Dismissed']
  end
end