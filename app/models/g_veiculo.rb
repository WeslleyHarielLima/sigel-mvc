class GVeiculo < ApplicationRecord
  belongs_to :g_status_veiculo, optional: true
  belongs_to :g_marca_veiculo, optional: true
  belongs_to :g_tipo_combustivel

  has_many :g_vistorias_veiculos
  has_many :g_avaliacoes_veiculos, dependent: :destroy

  validates :placa,   presence: true
  validates :chassi,  presence: true
  validates :renavam, presence: true

  def vistoria_iniciada?
    g_vistorias_veiculos.exists?
  end

  def checklist_completo?
    vistoria = g_vistorias_veiculos.order(created_at: :desc).first
    return false unless vistoria

    vistoria.g_checklists_veiculos.exists?
  end


  def avaliado?
    g_avaliacoes_veiculos.exists?
  end

  # 🔽 Helpers de status (pra view não quebrar)
  def status_label
    g_status_veiculo&.descricao || "Não definido"
  end

  def status_key
    status_label.parameterize.underscore
  end
end
