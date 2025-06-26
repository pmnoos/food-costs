Rails.application.routes.draw do
  devise_for :users
  get "reports/index"
  resources :products
  resources :stores
  resources :recipes
  resources :menus do
    member do
      post :add_recipe
      delete :remove_recipe
    end
  end
  
  # Settings and Help routes
  get "settings", to: "settings#index"
  get "help", to: "help#index"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Custom health check endpoint
  get "up" => "health#check", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "stores#index"
end
