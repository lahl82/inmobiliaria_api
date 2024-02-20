# typed: false
# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: '',
                     path_names: {
                       sign_in: 'login',
                       sign_out: 'logout',
                       registration: 'signup'
                     },
                     controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations'
                     }

  #   devise_for :users, controllers: {
  #     sessions: 'users/sessions',
  #     registrations: 'users/registrations'
  #   }
  #   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #   # Defines the root path route ("/")
  #   # root "articles#index"
  resources :services
  resources :service_types
  resources :users do
    member do
      get :services
    end
  end
end

# Rails.application.routes.draw do
#   # get 'current_user', to: 'current_user#index'
#   devise_for :users, path: '', path_names: {
#     sign_in: 'login',
#     sign_out: 'logout',
#     registration: 'signup'
#   }, controllers: {
#     sessions: 'users/sessions',
#     registrations: 'users/registrations'
#   }
# end
