# frozen_string_literal: true

class ATipoUsuario < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  has_many :users, dependent: :restrict_with_error

  validates :descricao, presence: true
end
