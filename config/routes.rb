Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    resources :tweets, :path => "news"
  end

  get '/api/:fecha1/:fecha2', to: 'api/tweets#between_dates'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets do 
    resources :friends
    resources :likes
    member do 
      post 'retweet'
      get 'retweet'
    end
  end

  get 'homes/index'

  devise_for :users
  root 'tweets#index'
end
