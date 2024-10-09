Rails.application.routes.draw do
  devise_for :users
  root to: "pages#dashboard"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  get "overview", to: "pages#overview"
  resources :pulses do
    resources :pulse_categories, only: [:index, :show]
    resources :questions, only: [:index, :show]
  end


  resources :categories, only: [:index, :show] do
    member do
      get 'questions', to: 'categories#question_first'
    end
  end

  resources :questions, only: [:index, :show] do
    resources :answers, only: [:create, :update, :destroy, :show]

  end

  get "dashboard/pulse", to: "dashboard#pulse", as: "pulse_dashboard"
end
