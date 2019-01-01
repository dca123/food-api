Rails.application.routes.draw do
  resources :weeks do
    get 'shopping_list', on: :member
  end
  resources :menus
  resources :meals
  resources :ingredients
  resources :recipes
  get 'meal_list', to: 'meals#list'
  get 'year_list', to: 'weeks#list'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
