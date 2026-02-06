# frozen_string_literal: true

Rails.application.routes.draw do
  resources :g_municipios
  devise_for :users

  root "home#index"
  get  "home/index"

  # Recursos principais
  resources :g_estados
  resources :g_paises

  get "up" => "rails/health#show", as: :rails_health_check
end
