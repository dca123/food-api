# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# enum location: [:walmart, :aldi, :other]
# enum measure: [:kg, :g, :box]

20.times do
  ingredient_name = Faker::Food.ingredient
  loop do
    ingredient_name = Faker::Food.ingredient
    break if !(Ingredient.find_by name:ingredient_name)
  end
  Ingredient.create(name: ingredient_name, location: rand(0..2))
end

10.times do
  dish_name = Faker::Food.dish
  loop do
    dish_name = Faker::Food.dish
    break if !(Meal.find_by name:dish_name)
  end
  Meal.create(name: dish_name, notes: Faker::Food.description, serves: rand(10..15))
end


50.times do
  ingredient_id = rand(1..20)
  meal_id = rand(1..10)
  loop do
    ingredient_id = rand(1..20)
    meal_id = rand(1..10)
    break if !(Recipe.find_by meal_id: meal_id, ingredient_id: ingredient_id)
  end
  Recipe.create(meal_id: meal_id, ingredient_id: ingredient_id, quantity: rand(5..15), measure: rand(0..2))
end
