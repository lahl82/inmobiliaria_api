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
  resources :appointment_slots, only: [:index, :show, :create, :update, :destroy] do
    collection do
      get 'for_month/:year/:month', action: :for_month
    end
    member do
      patch :suspend
      patch :resume
      patch :update_services
    end
  end
  resources :services do
    collection do
      get :mine
      get :basic_mine
    end
    member do
      get :appointment_slots
    end
  end
  resources :appointments, only: [:index, :create] do
    member do
      patch :cancel
    end
  end
  resources :service_types
  resources :users do
    member do
      get :services # paginado, con fotos
      get :basic_services # sin fotos, todos
      get :appointment_slots
    end
  end
end
