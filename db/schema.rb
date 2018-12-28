# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_21_052226) do

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.integer "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_ingredients_on_name", unique: true
  end

  create_table "meals", force: :cascade do |t|
    t.string "name"
    t.string "notes"
    t.integer "serves"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_meals_on_name", unique: true
  end

  create_table "menus", force: :cascade do |t|
    t.integer "week_id"
    t.integer "day"
    t.integer "meal_time"
    t.integer "meal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_id"], name: "index_menus_on_meal_id"
    t.index ["week_id", "day", "meal_time", "meal_id"], name: "index_menus_on_week_id_and_day_and_meal_time_and_meal_id", unique: true
    t.index ["week_id"], name: "index_menus_on_week_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.integer "meal_id"
    t.integer "ingredient_id"
    t.integer "quantity"
    t.integer "measure"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipes_on_ingredient_id"
    t.index ["meal_id", "ingredient_id"], name: "index_recipes_on_meal_id_and_ingredient_id", unique: true
    t.index ["meal_id"], name: "index_recipes_on_meal_id"
  end

  create_table "weeks", force: :cascade do |t|
    t.integer "week_of"
    t.integer "year"
    t.integer "month"
    t.decimal "cost", precision: 6, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["month"], name: "index_weeks_on_month"
    t.index ["week_of", "year"], name: "index_weeks_on_week_of_and_year", unique: true
    t.index ["week_of"], name: "index_weeks_on_week_of"
    t.index ["year"], name: "index_weeks_on_year"
  end

end
