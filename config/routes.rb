Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  root to: "homes#top"
  get "home/about" => "homes#about", as: "about"

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
    get "daily_posts" => "users#daily_posts"
  end
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :messages, only: [:create]
  resources :rooms, only: [:create, :index, :show]

  resources :groups do
    get "join" => "groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end

  resources :tags
  get "search" => "tags#search"
  # For details on the DS,L available within this file, see https://guides.rubyonrails.org/routing.html
end
