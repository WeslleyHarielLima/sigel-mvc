# app/models/g_vistoria_veiculo.rb
class GVistoriaVeiculo < ApplicationRecord
  belongs_to :g_veiculo
  belongs_to :user_responsavel,      class_name: "User", foreign_key: "user_id_responsavel"
  has_many   :g_checklists_veiculos, dependent: :destroy

  validates :g_veiculo,           presence: true
  validates :user_responsavel,    presence: true
  validates :data_vistoria,       presence: true

    def score_checklist
    itens = g_checklists_veiculos.includes(:g_tipo_item_checklist)

    return 0 if itens.empty?

    soma_pesos = itens.sum { |i| i.g_tipo_item_checklist.peso.to_f }
    soma_ponderada = itens.sum do |i|
      nota = i.resultado.to_f        # 0..10
      peso = i.g_tipo_item_checklist.peso.to_f
      nota * peso
    end

    return 0 if soma_pesos.zero?

    (soma_ponderada / soma_pesos).round(2) # score final 0..10
  end
end
