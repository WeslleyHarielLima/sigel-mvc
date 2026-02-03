# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  # Recursos principais
  resources :g_tipos_veiculos
  resources :g_veiculos

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root "g_veiculos#index"
end
