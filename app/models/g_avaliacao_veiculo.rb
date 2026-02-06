# app/models/g_avaliacao_veiculo.rb
class GAvaliacaoVeiculo < ApplicationRecord
  belongs_to :g_veiculo
  belongs_to :avaliador, class_name: "User", foreign_key: :user_id_avaliador

    before_validation :calcular_valores

  private

  def calcular_valores
    vistoria = g_veiculo.g_vistorias_veiculos.order(created_at: :desc).first
    return unless vistoria

    score = vistoria.score_checklist # 0..10

    # Regra de negócio (exemplo):
    # Score 10  => 0% depreciação extra
    # Score 5   => 20% depreciação
    # Score 0   => 40% depreciação

    fator_depreciacao = case score
    when 8..10 then 0.05   # 5%
    when 6..7.99 then 0.10 # 10%
    when 4..5.99 then 0.20 # 20%
    when 2..3.99 then 0.30 # 30%
    else 0.40              # 40%
    end

    self.pontuacao_checklist = score
    self.percentual_depreciacao = (fator_depreciacao * 100).round(2)

    if valor_mercado.present?
      self.valor_depreciado = (valor_mercado * fator_depreciacao).round(2)
      self.valor_inicial_lance = (valor_mercado - valor_depreciado).round(2)
    end
  end
end
