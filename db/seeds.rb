30.times do
  ingredient_name = Faker::Food.ingredient
  while Ingredient.exists?(name: ingredient_name)
    ingredient_name = Faker::Food.ingredient
  end
  Ingredient.create(name: ingredient_name, location: rand(0..2), category: rand(0..8))
end

30.times do
  dish_name = Faker::Food.dish
  while Meal.exists?(name: dish_name)
    dish_name = Faker::Food.dish
  end
  myMeal = Meal.create(name: dish_name, notes: Faker::Food.description, serves: 30, category: rand(0..4))

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
  2.times do |thisSemester|
    if thisSemester.even?
      semester = Semester.create(name: "Fall Semester #{2016 + thisYear}", spring:false, budget: rand(15000.00..20000.99), start: Date.new(2016+thisYear, 8, rand(10..25)).beginning_of_week,
    end: Date.new(2016+thisYear, 12, rand(10..15)).end_of_week)
    else
      semester = Semester.create(name: "Spring Semester #{2016 + thisYear}", spring:true, budget: rand(8000.00..15000.99), start: Date.new(2016+thisYear, 1, rand(10..25)).beginning_of_week,
    end: Date.new(2016+thisYear, 5, rand(10..15)).end_of_week)
    end
    20.times do |count|
        date = semester.start.advance(weeks: count).beginning_of_week
        myWeek = Week.create(week_of: date.day, month: date.month, semester_id: semester.id)
        2.times do |receipt|
          Receipt.create(week_id: myWeek.id, location: receipt, cost: rand(30.00...399.99), notes: "#{myWeek.id}  costs this !")
        end
        5.times do |weekDay|
          2.times do |mealT|
            rand(1..3).times do
              meal_id = rand(1..25)
              while Menu.exists?(week: myWeek.id, day: weekDay, meal_time: mealT, meal: meal_id)
                meal_id = rand(1..25)
              end
              puts "year #{2016+thisYear} count #{myWeek.id} weekDay #{weekDay} mealT #{mealT} meal_id #{meal_id}"
              Menu.create(week_id: myWeek.id, day: weekDay, meal_time: mealT, meal_id: meal_id)
            end
          end
        end
      end
  end
end
