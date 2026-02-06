# frozen_string_literal: true

Rails.application.routes.draw do
  resources :g_marcas_veiculos
  resources :g_veiculos
  resources :a_unidades
  resources :a_orgaos
  resources :a_tipos_usuarios
  resources :a_status
  resources :g_tipos_veiculos

  devise_for :users

  root "home#index"
  get  "home/index"

  # Recursos principais
  resources :g_estados
  resources :g_paises
  resources :g_status_leiloes_veiculos
  resources :g_status_veiculos
  resources :g_distritos
  resources :g_municipios

  get "up" => "rails/health#show", as: :rails_health_check
end
