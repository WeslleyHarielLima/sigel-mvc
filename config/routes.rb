# frozen_string_literal: true

Rails.application.routes.draw do
  resources :g_status_leiloes_veiculos
  resources :g_status_veiculos
  devise_for :users

  root "g_veiculos#index"
  get  "home/index"

  # Recursos principais
  resources :g_veiculos
  resources :g_localidades
  resources :g_distritos
  resources :g_municipios
  resources :g_estados
  resources :g_paises

  get "up" => "rails/health#show", as: :rails_health_check
end
