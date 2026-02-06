# app/models/g_veiculo.rb
class GVeiculo < ApplicationRecord
  belongs_to :g_status_veiculo

  validates :placa, presence: true
  validates :chassi, presence: true
  validates :renavam, presence: true
end
