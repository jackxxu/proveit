Proveit::Application.routes.draw do
  root :to => 'cases#index'
  resources :cases, only: [:index, :show]
  resources :labels, only: [:index, :new, :create]
end
