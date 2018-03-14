Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  
  get 'home/about'
  get 'home/lookup'

  post'/home/lookup' => 'home/lookup'
end
