# frozen_string_literal: true

class GMunicipio < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  belongs_to :g_estado
  has_many   :g_distritos
end
