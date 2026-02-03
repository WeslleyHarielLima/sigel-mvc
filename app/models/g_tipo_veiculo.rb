# frozen_string_literal: true

class GTipoVeiculo < ApplicationRecord
  include Discard::Model

  self.table_name = "g_tipos_veiculos"

  has_many :g_veiculos, dependent: :restrict_with_error

  validates :descricao, presence: true, uniqueness: { case_sensitive: false }

  default_scope -> { kept }

  def to_s
    descricao
  end
end
