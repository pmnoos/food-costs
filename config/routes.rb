Rails.application.routes.draw do
  resources :product_price_history, only: [ :index ]
  devise_for :users
  resources :reports, only: [ :index ]
  resources :products do
    collection do
      get :autocomplete
    end
  end
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

  authenticated :user do
    root "stores#index", as: :authenticated_root
  end

  unauthenticated do
    root "home#index", as: :unauthenticated_root
  end
end
