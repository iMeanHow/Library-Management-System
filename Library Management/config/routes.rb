Rails.application.routes.draw do

  resources :book_marks
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
  get 'librarianrequest', to: 'users#viewrequests', as: 'librarian_requests'
  get 'searchreult', to: 'books#booksearch', as: 'book_search'
  get 'approve', to: 'users#approvelibrarian', as: 'approve_librarian_requests'
  get 'books/:id/borrow', to: 'books#borrow', as: 'borrow_book'
  get 'borrow_without_check', to: 'books#borrow_without_check_2', as: 'borrow_book_without_check'
  get 'books/:id/mark_book', to: 'books#mark_book', as: 'mark_book'
  get 'books/:id/unmark_book', to: 'books#unmark_book', as: 'unmark_book'
  get 'books/:id/book_request', to: 'books#book_request', as: 'request_book'
  get 'books_approve', to: 'book_requests#approve', as: 'approve_book_request'
  get 'books_deny', to: 'book_requests#deny', as: 'deny_book_request'
  get 'book_histories/:id/book_return', to: 'book_histories#book_return', as: 'book_return'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
