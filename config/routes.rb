Rails.application.routes.draw do
  root to: "ads#index"
  resources :ads
end
