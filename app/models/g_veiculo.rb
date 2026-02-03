# frozen_string_literal: true

class GVeiculo < ApplicationRecord
  include Discard::Model

  belongs_to :g_tipo_veiculo

  STATUSES = {
    "pendente" => "Pendente",
    "verificado_apto" => "Verificado/Apto",
    "em_leilao" => "Em Leilão",
    "arrematado" => "Arrematado",
    "impedido" => "Impedido"
  }.freeze

  validates :status, inclusion: { in: STATUSES.keys }
  validates :g_tipo_veiculo_id, presence: true
  validates :ano, numericality: { only_integer: true, allow_nil: true }

  default_scope -> { kept }

  scope :aptos, -> { where(apto: true) }
  scope :por_status, ->(status) { where(status: status) if status.present? }
  scope :por_tipo, ->(tipo_id) { where(g_tipo_veiculo_id: tipo_id) if tipo_id.present? }

  def self.ransackable_attributes(auth_object = nil)
    %w[numero_interno placa chassi renavam marca modelo ano cor status apto g_tipo_veiculo_id created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[g_tipo_veiculo]
  end

  def status_label
    STATUSES[status] || status
  end

  def to_s
    "#{marca} #{modelo} - #{placa}"
  end
end
