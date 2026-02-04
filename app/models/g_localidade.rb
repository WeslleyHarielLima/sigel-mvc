# frozen_string_literal: true

class GLocalidade < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  belongs_to :g_distrito
end
