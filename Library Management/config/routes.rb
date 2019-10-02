Rails.application.routes.draw do

  resources :book_searches
  resources :book_requests
  resources :book_histories
  resources :users
  resources :sessions
  resources :admins
  resources :libraries
  resources :librarians
  resources :students
  resources :books

  root 'home#index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'home/index'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'librarianrequest', to: 'librarians#viewrequests', as: 'librarian_requests'
  get 'books/:id/borrow', to: 'books#borrow', as: 'borrow_book'
  get 'books/:id/book_request', to: 'books#book_request', as: 'request_book'
  get 'books/:id/return', to: 'books#book_return', as: 'book_return'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
