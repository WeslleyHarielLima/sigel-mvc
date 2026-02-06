# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get  "home/index"
  get "fluxo-avaliacao",                                    to: "fluxo_avaliacao#index",            as: :fluxo_avaliacao
  get  "fluxo-avaliacao/:id/avaliar",                       to: "fluxo_avaliacao#avaliar",          as: :fluxo_avaliar
  get  "vistorias/:g_vistoria_veiculo_id/checklist-lote",   to: "g_checklists_veiculos#lote",       as: :checklist_lote
  post "vistorias/:g_vistoria_veiculo_id/checklist-lote",   to: "g_checklists_veiculos#salvar_lote"
  post "fluxo_avaliacao/:id/avaliar",                       to: "fluxo_avaliacao#salvar_avaliacao", as: :fluxo_avaliar_salvar

  resources :g_vistorias_veiculos do
    get  "checklist", to: "checklists#preencher"
    post "checklist", to: "checklists#salvar"
  end

  # Recursos principais
  resources :a_unidades
  resources :a_orgaos
  resources :a_tipos_usuarios
  resources :a_status
  resources :g_estados
  resources :g_paises
  resources :g_status_leiloes_veiculos
  resources :g_status_veiculos
  resources :g_distritos
  resources :g_municipios
  resources :g_marcas_veiculos
  resources :g_veiculos
  resources :g_tipos_veiculos
  resources :g_checklists_veiculos
  resources :g_estados_conservacao_veiculos
  resources :g_tipos_itens_checklists
  resources :g_avaliacoes_veiculos
  resources :g_tipos_combustiveis
  resources :i_status_inserviveis
  resources :i_status_serviveis

  get "up" => "rails/health#show", as: :rails_health_check
end
