# frozen_string_literal: true

Rails.application.routes.draw do
  # Static Pages
  root 'static_pages#home'
  get 'help', to: 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup' => 'users#new'

  # Resource users
  resources :users

  # Resource sessions
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
