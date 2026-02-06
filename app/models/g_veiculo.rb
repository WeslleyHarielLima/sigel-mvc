# app/models/g_veiculo.rb
class GVeiculo < ApplicationRecord
  belongs_to :g_status_veiculo
  belongs_to :g_marca_veiculo, optional: true
  belongs_to :g_tipo_combustivel

  validates :placa, presence: true
  validates :chassi, presence: true
  validates :renavam, presence: true
end
