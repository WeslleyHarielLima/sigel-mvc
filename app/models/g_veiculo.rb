class GVeiculo < ApplicationRecord
  belongs_to :g_status_veiculo
  belongs_to :g_marca_veiculo, optional: true
  belongs_to :g_tipo_combustivel

  has_many :g_vistorias_veiculos
  has_many :g_avaliacoes_veiculos, class_name: "GAvaliacaoVeiculo"

  validates :placa,   presence: true
  validates :chassi,  presence: true
  validates :renavam, presence: true

  def vistoria_iniciada?
    g_vistorias_veiculos.exists?
  end

  def checklist_completo?
    vistoria = g_vistorias_veiculos.order(created_at: :desc).first
    return false unless vistoria

    total_itens = GTipoItemChecklist.count
    respondidos = vistoria.g_checklists_veiculos.count

    total_itens.positive? && respondidos == total_itens
  end

  def avaliado?
    g_avaliacoes_veiculos.exists?
  end
end
