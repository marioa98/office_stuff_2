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

  def category_color
    {
      "Books": "background-color: brown; color: white",
      "Stationery": "background-color: green; color: black",
      "Service department": "background-color: red; color: white",
      "Cleaning": "background-color: blue; color: white",
      "Furniture": "background-color: grey; color: black",
      "Hardware reparations": "background-color: purple; color: white",
      "Kitchen stuff": "background-color: orange; color: black",
      "Licences and equipment": "background-color: yellow; color: black",
      "Other": "background-color: black; color: white"
    }
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