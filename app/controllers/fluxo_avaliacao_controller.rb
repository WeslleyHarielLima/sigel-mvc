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
end
