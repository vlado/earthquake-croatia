Rails.application.routes.draw do
  root to: "ads#index"
  resources :ads
  resources :cities, only: :index
end
