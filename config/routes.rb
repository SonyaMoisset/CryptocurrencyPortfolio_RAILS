Rails.application.routes.draw do
  root 'home#index'
  
  get 'home/about'
  get 'home/lookup'

  post'/home/lookup' => 'home/lookup'
end
