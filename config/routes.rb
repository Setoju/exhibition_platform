Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    get "/", to: "dashboard#index", as: :dashboard
    resources :exhibition_centers do
      resources :rooms do
        resources :exhibitions do
          resources :exhibits
        end
      end
    end
    resources :rooms do
      resources :exhibitions, only: [ :new, :create, :index, :show, :edit, :update, :destroy ]
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "exhibitions#index"

  resources :exhibitions, only: [ :index, :show ] do
    resources :exhibits, only: [ :new, :create ]
    resource :favourite, only: [ :create, :destroy ]
  end

  resources :exhibits, only: [ :index, :show ]
  resources :exhibition_centers, only: [ :new, :create ]
  resources :rooms, only: [ :new, :create ]
  resources :favourites, only: [ :index ]
end
