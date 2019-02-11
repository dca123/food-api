Rails.application.routes.draw do
  resources :semesters
  resources :receipts
  resources :weeks do
    get 'shopping_list', on: :member
  end
  resources :menus
  resources :meals
  resources :ingredients
  resources :recipes
  get 'report', to: 'weeks#report'
  get 'meal_list', to: 'meals#list'
  get 'year_list', to: 'semesters#list'
  get 'ingredient_list', to: 'ingredients#list'
  get 'measure_list', to: 'recipes#list'
  get 'ingredient_category_list', to: 'ingredients#category'
  get 'meal_category_list', to: 'meals#category'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
