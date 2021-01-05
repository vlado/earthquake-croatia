Rails.application.routes.draw do
  root to: "ads#index"
  resources :ads do
    resource :delete, only: [:new], controller: "ads/delete"
    resource :token, only: [:new, :create], controller: "ads/token"
  end
end
