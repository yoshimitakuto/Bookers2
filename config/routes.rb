Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/show'
  # get 'users/edit'
  # get 'books/index'
  # get 'books/show'
  # get 'books/edit'
  devise_for :users
  root to: 'homes#top'
  # resources :users, only:[:index, :show, :edit, :update]
  # resources :books, only:[:index, :create, :show, :edit, :update, :destroy]
  get 'home/about' => 'homes#about', as: 'about'
  resources :users
  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
