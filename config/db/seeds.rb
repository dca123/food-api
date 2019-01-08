
File.open("db/seedData/ingredients.walmart.seed", "r") do |f|
  f.each_line do |line|
    Ingredient.create(name: line.strip, location: :walmart)
  end
end

File.open("db/seedData/ingredients.aldi.seed", "r") do |f|
  f.each_line do |line|
    Ingredient.create(name: line.strip, location: :aldi)
  end
end
