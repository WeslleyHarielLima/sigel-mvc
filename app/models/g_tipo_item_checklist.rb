# frozen_string_literal: true

class GTipoItemChecklist < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  has_many :g_checklists_veiculos
end
