# config/routes.rb
require "sidekiq/web"

Rails.application.routes.draw do
  # ---- USER AUTH ----
  get  "/signup",      to: "users#new"
  post "/signup",      to: "users#create"

  get  "/user_login",  to: "user_sessions#new"
  post "/user_login",  to: "user_sessions#create"
  delete "/user_logout", to: "user_sessions#destroy"

  # ---- ADMIN AUTH (already added before) ----
  get  "/login",  to: "sessions#new"
  post "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/admin", to: "admin/dashboard#index", as: :admin_dashboard

  # Protect Sidekiq UI (if you kept this)
  # Sidekiq::Web.use Rack::Auth::Basic do |user, pass|
  #   user == "admin" && pass == "admin123"
  # end

  mount Sidekiq::Web => "/sidekiq"

  # ---- MAIN APP ----
  root "home#index"
  post "/trigger", to: "home#trigger"
  get "/search",  to: "home#search"
  get "/jobs",    to: "home#jobs"

  # ---- API (if you added earlier) ----
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show]
      get "/users/search", to: "users#search"
    end
  end
end

