Rails.application.routes.draw do
  root 'interviews#index'
  get 'new' => 'interviews#new'
  
  resources :interviews
  resources :users
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  namespace :api do
  	namespace :v1 do
  		resources :interviews
  		resources :users
  	end
  end
  get '*path' , to: 'interviews#index' , via: :all
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
