# app/controllers/fluxo_avaliacao_controller.rb
class FluxoAvaliacaoController < ApplicationController
  def index
    @aguardando_vistoria = GVeiculo
      .left_joins(:g_vistorias_veiculos)
      .where(g_vistorias_veiculos: { id: nil })
      .distinct

    @em_checklist = GVeiculo
      .joins(:g_vistorias_veiculos)
      .left_joins(:g_avaliacoes_veiculos)
      .where(g_avaliacoes_veiculos: { id: nil })
      .distinct

    @avaliados = GVeiculo
      .joins(:g_avaliacoes_veiculos)
      .distinct
  end

  def avaliar
    @veiculo  = GVeiculo.find(params[:id])
    @vistoria = @veiculo.g_vistorias_veiculos.last
    @avaliacao = GAvaliacaoVeiculo.new(g_veiculo: @veiculo, user_id_avaliador: current_user.id)
    @pontuacao_checklist = @vistoria.g_checklists_veiculos.sum(:resultado) rescue 0
  end
end
