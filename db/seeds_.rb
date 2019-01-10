
File.open("db/seedData/ingredients.walmart.seed", "r") do |f|
  f.each_line do |line|
    data = line.split(",")
    Ingredient.create(name: data[0].strip, category:data[1].strip, location: :walmart)
  end
end

File.open("db/seedData/ingredients.aldi.seed", "r") do |f|
  f.each_line do |line|
    data = line.split(",")
    Ingredient.create(name: data[0].strip, category:data[1].strip, location: :aldi)
  end
end
File.open("db/seedData/11.12.seed", "r") do |f|
  meal = nil
  f.each_line do |line|
    data = line.split(",")
    if data[0].strip == ""
      puts "Enter Meal Name"
      name = STDIN.gets.chomp

      puts "Enter category"
      category = STDIN.gets.chomp
      meal = Meal.create(name: name, category: category, serves: 30, notes: '')
    else
        ingredient = Ingredient.find_by(name: data[2].strip)
        Recipe.create(meal_id: meal.id, ingredient_id: ingredient.id, measure: data[1].strip, quantity: data[0].strip.to_i)
    end
  end
end

# input = ''
# while input != 'end'
#   puts "Enter Meal Name"
#   name = STDIN.gets.chomp
#   puts "Enter Category"
#   category = STDIN.gets.chomp
#
#   meal = Meal.create(name: name, category: category, serves: 30, notes: '')
#   puts "Meal Created"
#
#   puts "Enter no of ingredients"
#   count = STDIN.gets.chomp
#
#   count.to_i.times do |variable|
#     ingredient = nil
#     while (ingredient == nil)
#       puts "Enter Ingredient Name"
#       ig_name = STDIN.gets.chomp
#       ingredient = Ingredient.find_by(name: ig_name)
#       puts ingredient
#     end
#
#     puts "Enter quantity"
#     quantity = STDIN.gets.chomp
#     puts "Enter Measure"
#     measure = STDIN.gets.chomp
#     Recipe.create(meal_id: meal.id, ingredient_id: ingredient.id, measure: measure, quantity: quantity)
#     puts "Recipe Created !"
#   end
#   input = STDIN.gets.chomp
# end
