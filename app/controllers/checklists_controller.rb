# app/controllers/checklists_controller.rb
class ChecklistsController < ApplicationController
  before_action :set_vistoria

  def preencher
    @tipos_itens = GTipoItemChecklist.order(:descricao)   # catálogo
    @estados     = GEstadoConservacaoVeiculo.order(:descricao)
    @existentes  = @vistoria.g_checklists_veiculos.includes(:g_tipo_item_checklist)
  end

  def salvar
    itens = params[:itens] || []

    if itens.blank?
      flash.now[:alert] = "Adicione pelo menos um item ao checklist."
      return render :preencher, status: :unprocessable_entity
    end

    ActiveRecord::Base.transaction do
      @vistoria.g_checklists_veiculos.destroy_all

      itens.each do |dados|
        GChecklistVeiculo.create!(
          g_vistoria_veiculo: @vistoria,
          g_tipo_item_checklist_id: dados[:g_tipo_item_checklist_id],
          g_estado_conservacao_veiculo_id: dados[:g_estado_conservacao_veiculo_id],
          resultado: dados[:resultado],
          observacao: dados[:observacao]
        )
      end
    end

    redirect_to fluxo_avaliacao_path, notice: "Checklist finalizado com sucesso."
  rescue => e
    flash.now[:alert] = "Erro ao salvar checklist: #{e.message}"
    render :preencher, status: :unprocessable_entity
  end

  private

  def set_vistoria
    @vistoria = GVistoriaVeiculo.find(params[:g_vistoria_veiculo_id])
  end
end
