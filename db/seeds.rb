# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# enum location: [:walmart, :aldi, :other]
# enum measure: [:kg, :g, :box]

30.times do
  ingredient_name = Faker::Food.ingredient
  while Ingredient.exists?(name: ingredient_name)
    ingredient_name = Faker::Food.ingredient
  end
  Ingredient.create(name: ingredient_name, location: rand(0..2))
end

30.times do
  dish_name = Faker::Food.dish
  while Meal.exists?(name: dish_name)
    dish_name = Faker::Food.dish
  end
  myMeal = Meal.create(name: dish_name, notes: Faker::Food.description, serves: rand(10..15), category: rand(0..4))

  rand(5...15).times do
    ingredient_id = rand(1..20)
    meal_id = myMeal.id
    while Recipe.exists?(ingredient_id: ingredient_id, meal_id: meal_id)
      ingredient_id = rand(1..20)
    end
    Recipe.create(meal_id: meal_id, ingredient_id: ingredient_id, quantity: rand(5..15), measure: rand(0..2))
  end
end

3.times do |thisYear|
  20.times do |count|
    myWeek = Week.create(week_of: count +1, year: 2017+thisYear, month: Date.commercial(2018, count + 1).month, cost: rand(30.00...200.99))
    5.times do |weekDay|
      2.times do |mealT|
        rand(1..3).times do
          meal_id = rand(1..25)
          while Menu.exists?(week: myWeek.id, day: weekDay, meal_time: mealT, meal: meal_id)
            meal_id = rand(1..25)
          end
          puts "year #{2017+thisYear} count #{myWeek.id} weekDay #{weekDay} mealT #{mealT} meal_id #{meal_id}"
          Menu.create(week_id: myWeek.id, day: weekDay, meal_time: mealT, meal_id: meal_id)
        end
      end
    end
  end
end
