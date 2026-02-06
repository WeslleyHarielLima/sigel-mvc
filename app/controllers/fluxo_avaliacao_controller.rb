# app/controllers/fluxo_avaliacao_controller.rb
class FluxoAvaliacaoController < ApplicationController
  before_action :set_veiculo, only: %i[avaliar salvar_avaliacao]

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
    @vistoria = @veiculo.g_vistorias_veiculos.order(created_at: :desc).first

    unless @vistoria
      redirect_to fluxo_avaliacao_path, alert: "Este veículo ainda não possui vistoria."
      return
    end

    unless @vistoria.g_checklists_veiculos.exists?
      redirect_to fluxo_avaliacao_path, alert: "Checklist ainda não foi preenchido."
      return
    end

    unless @veiculo.checklist_completo?
      redirect_to fluxo_avaliacao_path, alert: "Checklist ainda não foi concluído."
      return
    end

    if @veiculo.avaliado?
      redirect_to fluxo_avaliacao_path, alert: "Este veículo já foi avaliado."
      return
    end

    @avaliacao = GAvaliacaoVeiculo.new(
      g_veiculo: @veiculo,
      user_id_avaliador: current_user.id
    )

@pontuacao_checklist = @vistoria.score_checklist
  end


  def salvar_avaliacao
  @avaliacao = GAvaliacaoVeiculo.new(avaliacao_params.merge(
    g_veiculo: @veiculo,
    user_id_avaliador: current_user.id,
    avaliado_em: Time.current
  ))

  if @avaliacao.save
    redirect_to fluxo_avaliacao_path, notice: "Avaliação registrada com sucesso."
  else
    @vistoria = @veiculo.g_vistorias_veiculos.order(created_at: :desc).first
    @pontuacao_checklist = @vistoria.score_checklist
    render :avaliar, status: :unprocessable_entity
  end
  end


  private

  def set_veiculo
    @veiculo = GVeiculo.find(params[:id])
  end

  def avaliacao_params
    params.require(:g_avaliacao_veiculo).permit(
      :valor_mercado,
      :valor_referencia_fipe,
      :percentual_depreciacao,
      :valor_depreciado,
      :valor_inicial_lance,
      :pontuacao_checklist
    )
  end
end
