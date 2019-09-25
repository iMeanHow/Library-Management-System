Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admin
  resources :librarians
  resources :libraries
  resource  :books
  resource  :students
  resource  :application
  resource  :visitor
  resource  :login

  #root 'login#index'
end
