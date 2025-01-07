Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  devise_for :users

  root to: "home#index"
  resources :tests, only: %i(show) do
    get "/do", to: "tests#do", on: :member
  end

  namespace :admin do
    root to: "home#index"
    resources :tests, only: %i(show new create)
  end
end
