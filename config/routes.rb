# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'messages#index'
  get '/healthcheck', to: 'healthcheck#index'

  devise_for :users,
             path: '/',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               sign_up: 'signup'
             },
             controllers: {
               sessions: 'devise_overrides/sessions'
             }

  resources :messages, only: [:index]

  get '/dbdump', to: 'database_dumps#index', as: 'database_dumps'
  get '/dump_database', to: 'database_dumps#dump', as: 'dump_database'
end
