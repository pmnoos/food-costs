# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create a sample user if none exists
user = User.find_or_create_by!(email: 'test@example.com') do |u|
  u.password = 'password123'
  u.password_confirmation = 'password123'
end

# Create sample stores
stores = [
  { name: 'Woolworths', location: 'Sydney CBD' },
  { name: 'Coles', location: 'Bondi Junction' },
  { name: 'Aldi', location: 'Parramatta' },
  { name: 'IGA', location: 'Manly' }
]

stores.each do |store_data|
  Store.find_or_create_by!(name: store_data[:name], user_id: user.id) do |s|
    s.location = store_data[:location]
  end
end

# Create sample recipes
recipes = [
  {
    name: 'Spaghetti Carbonara',
    cuisine: 'Italian',
    difficulty: 'Intermediate',
    prep_time: 15,
    cook_time: 20,
    servings: 4,
    occasion: 'Weeknight Dinner',
    ingredients: "• 400g spaghetti\n• 200g pancetta or guanciale\n• 4 large eggs\n• 100g Pecorino Romano cheese\n• 100g Parmigiano Reggiano\n• Black pepper to taste\n• Salt for pasta water",
    instructions: "1. Bring a large pot of salted water to boil and cook spaghetti according to package directions.\n\n2. While pasta cooks, cut pancetta into small cubes and cook in a large skillet over medium heat until crispy.\n\n3. In a bowl, whisk together eggs, grated cheeses, and black pepper.\n\n4. Drain pasta, reserving 1 cup of pasta water. Add hot pasta to the skillet with pancetta.\n\n5. Remove from heat and quickly stir in the egg mixture, adding pasta water as needed to create a creamy sauce.\n\n6. Serve immediately with extra cheese and black pepper."
  },
  {
    name: 'Chicken Tikka Masala',
    cuisine: 'Indian',
    difficulty: 'Intermediate',
    prep_time: 30,
    cook_time: 45,
    servings: 6,
    occasion: 'Family Dinner',
    ingredients: "• 1kg chicken breast, cubed\n• 2 cups yogurt\n• 2 tbsp garam masala\n• 2 tbsp turmeric\n• 2 onions, diced\n• 4 cloves garlic, minced\n• 2 tbsp ginger, grated\n• 400ml coconut milk\n• 400g canned tomatoes\n• Fresh cilantro for garnish",
    instructions: "1. Marinate chicken in yogurt, garam masala, and turmeric for at least 2 hours.\n\n2. Cook marinated chicken in a hot pan until browned on all sides.\n\n3. In a large pot, sauté onions, garlic, and ginger until fragrant.\n\n4. Add coconut milk and tomatoes, bring to a simmer.\n\n5. Add cooked chicken and simmer for 20-30 minutes until sauce thickens.\n\n6. Garnish with fresh cilantro and serve with rice or naan."
  },
  {
    name: 'Pad Thai',
    cuisine: 'Thai',
    difficulty: 'Advanced',
    prep_time: 25,
    cook_time: 15,
    servings: 4,
    occasion: 'Weeknight Dinner',
    ingredients: "• 200g rice noodles\n• 200g shrimp or chicken\n• 2 eggs\n• 2 cups bean sprouts\n• 4 green onions\n• 1/4 cup peanuts, crushed\n• 2 tbsp fish sauce\n• 2 tbsp tamarind paste\n• 2 tbsp palm sugar\n• Lime wedges for serving",
    instructions: "1. Soak rice noodles in warm water for 30 minutes.\n\n2. Heat oil in a wok over high heat and cook protein until done.\n\n3. Push protein to one side and scramble eggs in the same pan.\n\n4. Add drained noodles and stir-fry for 2-3 minutes.\n\n5. Add fish sauce, tamarind paste, and palm sugar.\n\n6. Add bean sprouts and green onions, cook for 1 minute.\n\n7. Serve with crushed peanuts and lime wedges."
  },
  {
    name: 'Beef Tacos',
    cuisine: 'Mexican',
    difficulty: 'Beginner',
    prep_time: 20,
    cook_time: 15,
    servings: 4,
    occasion: 'Weeknight Dinner',
    ingredients: "• 500g ground beef\n• 1 packet taco seasoning\n• 8 taco shells\n• 1 cup shredded lettuce\n• 1 cup diced tomatoes\n• 1 cup shredded cheese\n• 1/2 cup sour cream\n• 1/4 cup salsa",
    instructions: "1. Brown ground beef in a large skillet over medium heat.\n\n2. Drain excess fat and add taco seasoning with water as directed.\n\n3. Simmer for 5 minutes until thickened.\n\n4. Warm taco shells according to package directions.\n\n5. Fill shells with beef mixture and top with lettuce, tomatoes, cheese, sour cream, and salsa.\n\n6. Serve immediately."
  },
  {
    name: 'Chocolate Lava Cake',
    cuisine: 'French',
    difficulty: 'Intermediate',
    prep_time: 15,
    cook_time: 12,
    servings: 4,
    occasion: 'Date Night',
    ingredients: "• 200g dark chocolate\n• 200g butter\n• 4 eggs\n• 4 egg yolks\n• 100g sugar\n• 100g flour\n• Pinch of salt\n• Butter and cocoa powder for ramekins",
    instructions: "1. Preheat oven to 200°C and butter 4 ramekins, dust with cocoa powder.\n\n2. Melt chocolate and butter together in a double boiler.\n\n3. Whisk eggs, egg yolks, and sugar until pale and fluffy.\n\n4. Fold melted chocolate into egg mixture.\n\n5. Gently fold in flour and salt.\n\n6. Divide batter among ramekins and bake for 10-12 minutes.\n\n7. Serve immediately while centers are still molten."
  }
]

recipes.each do |recipe_data|
  Recipe.find_or_create_by!(name: recipe_data[:name], user: user) do |r|
    r.cuisine = recipe_data[:cuisine]
    r.difficulty = recipe_data[:difficulty]
    r.prep_time = recipe_data[:prep_time]
    r.cook_time = recipe_data[:cook_time]
    r.servings = recipe_data[:servings]
    r.occasion = recipe_data[:occasion]
    r.ingredients = recipe_data[:ingredients]
    r.instructions = recipe_data[:instructions]
  end
end

# Create sample menus
menus = [
  {
    name: 'Italian Family Feast',
    occasion: 'Family Dinner',
    date: Date.current + 3.days,
    cuisine: 'Italian',
    servings: 6,
    description: 'A complete Italian meal perfect for family gatherings with classic dishes that everyone will love.'
  },
  {
    name: 'Date Night Special',
    occasion: 'Date Night',
    date: Date.current + 1.day,
    cuisine: 'French',
    servings: 2,
    description: 'An elegant French-inspired menu perfect for a romantic evening at home.'
  },
  {
    name: 'Weekend Brunch',
    occasion: 'Weekend Brunch',
    date: Date.current + 2.days,
    cuisine: 'American',
    servings: 4,
    description: 'A delicious brunch spread with both sweet and savory options for a relaxing weekend morning.'
  }
]

menus.each do |menu_data|
  Menu.find_or_create_by!(name: menu_data[:name], user: user) do |m|
    m.occasion = menu_data[:occasion]
    m.date = menu_data[:date]
    m.cuisine = menu_data[:cuisine]
    m.servings = menu_data[:servings]
    m.description = menu_data[:description]
  end
end

# Add recipes to menus
italian_menu = Menu.find_by(name: 'Italian Family Feast', user: user)
spaghetti_recipe = Recipe.find_by(name: 'Spaghetti Carbonara', user: user)
if italian_menu && spaghetti_recipe
  italian_menu.recipes << spaghetti_recipe unless italian_menu.recipes.include?(spaghetti_recipe)
end

date_menu = Menu.find_by(name: 'Date Night Special', user: user)
chocolate_recipe = Recipe.find_by(name: 'Chocolate Lava Cake', user: user)
if date_menu && chocolate_recipe
  date_menu.recipes << chocolate_recipe unless date_menu.recipes.include?(chocolate_recipe)
end

puts "Sample data created successfully!"
puts "User: test@example.com / password123"
puts "Created #{Store.count} stores"
puts "Created #{Recipe.count} recipes"
puts "Created #{Menu.count} menus"
