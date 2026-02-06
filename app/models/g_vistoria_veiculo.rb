# app/models/g_vistoria_veiculo.rb
class GVistoriaVeiculo < ApplicationRecord
  belongs_to :g_veiculo
  belongs_to :user_responsavel,      class_name: "User", foreign_key: "user_id_responsavel"
  has_many   :g_checklists_veiculos, dependent: :destroy

  validates :g_veiculo,           presence: true
  validates :user_responsavel,    presence: true
  validates :data_vistoria,       presence: true
end
