# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get '/healthcheck', to: 'healthcheck#index'

  devise_for :users,
             path: '/',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               sign_up: 'signup'
             },
             controllers: {
               registrations: 'devise_overrides/registrations',
               sessions: 'devise_overrides/sessions',
               confirmations: 'devise_overrides/confirmations'
  }

  resources :messages, except: %i[edit update] do
    collection do
      get :outbox
    end
  end

  get '/dbdump', to: 'database_dumps#index', as: 'database_dumps'
  get '/dump_database', to: 'database_dumps#dump', as: 'dump_database'
end
