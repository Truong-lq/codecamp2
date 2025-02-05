Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  devise_for :users

  root to: "home#index"

  resources :tests, only: :show do
    member do
      get "/do", to: "tests#do"
      post "/submit", to: "tests#submit"
    end
  end

  namespace :admin do
    resources :tests, except: :show
  end
end
