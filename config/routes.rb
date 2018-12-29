Rails.application.routes.draw do
  resources :weeks
  resources :menus
  resources :meals do
  end
  resources :ingredients
  resources :recipes
  get 'meal_list', to: 'meals#list'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
