Category.create([{category_name: 'Computer accesories'}, 
    {category_name: 'Books' },
    {category_name: 'Stationery'}, 
    {category_name: 'Service department'},
    {category_name: 'Cleaning'}, 
    {category_name: 'Furniture'},
    {category_name: 'Hardware reparations'},
    {category_name: 'Kitchen stuff'},
    {category_name: 'Licences and equipment'},
    {category_name: 'Other'}])
User.create(full_name: 'Anonymous', username: 'anon', password: 'abcd1234')

puts "All data loaded"