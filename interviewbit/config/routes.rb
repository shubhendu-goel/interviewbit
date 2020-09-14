Rails.application.routes.draw do
  root 'interviews#index'
  get 'new' => 'interviews#new'
  resources :interviews
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
