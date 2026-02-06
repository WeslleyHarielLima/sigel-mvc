# frozen_string_literal: true

class GChecklistsVeiculosController < ApplicationController
  before_action :set_g_checklist_veiculo, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  # =========================
  # CRUD ADMINISTRATIVO
  # =========================

  def index
    @q = GChecklistVeiculo.ransack(params[:q])
    @pagy, @g_checklists_veiculos = pagy(@q.result.includes(:g_vistoria_veiculo, :g_tipo_item_checklist, :g_estado_conservacao_veiculo))
  end

  def show; end

  def new
    @g_checklist_veiculo = GChecklistVeiculo.new
    load_collections
  end

  def edit
    load_collections
  end

  def create
    @g_checklist_veiculo = GChecklistVeiculo.new(g_checklist_veiculo_params)

    if @g_checklist_veiculo.save
      redirect_to g_checklists_veiculos_path, notice: t("messages.created_successfully")
    else
      load_collections
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_checklist_veiculo.update(g_checklist_veiculo_params)
      redirect_to g_checklists_veiculos_path, notice: t("messages.updated_successfully"), status: :see_other
    else
      load_collections
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_checklist_veiculo.destroy
      redirect_to g_checklists_veiculos_url, notice: t("messages.deleted_successfully")
    else
      redirect_to g_checklists_veiculos_url, alert: t("messages.delete_failed_due_to_dependencies")
    end
  end

  # =========================
  # FLUXO OPERACIONAL (EM LOTE POR VISTORIA)
  # =========================

  def lote
    @vistoria = GVistoriaVeiculo.find(params[:g_vistoria_veiculo_id])
    @itens = GTipoItemChecklist.order(:descricao)
    @estados = GEstadoConservacaoVeiculo.order(:descricao)
  end

  def salvar_lote
    @vistoria = GVistoriaVeiculo.find(params[:g_vistoria_veiculo_id])
    itens = params[:itens] || {}

    ActiveRecord::Base.transaction do
      itens.each do |tipo_item_id, dados|
        GChecklistVeiculo.create!(
          g_vistoria_veiculo_id: @vistoria.id,
          g_tipo_item_checklist_id: tipo_item_id,
          g_estado_conservacao_veiculo_id: dados[:g_estado_conservacao_veiculo_id],
          resultado: dados[:resultado],
          observacao: dados[:observacao]
        )
      end
    end

    redirect_to fluxo_avaliacao_path, notice: "Checklist preenchido com sucesso."
  rescue => e
    flash.now[:alert] = "Erro ao salvar checklist: #{e.message}"
    @itens = GTipoItemChecklist.order(:descricao)
    @estados = GEstadoConservacaoVeiculo.order(:descricao)
    render :lote, status: :unprocessable_entity
  end

  private

  # =========================
  # HELPERS INTERNOS
  # =========================

  def load_collections
    @g_vistorias_veiculos = GVistoriaVeiculo.includes(:g_veiculo).order(created_at: :desc)
    @g_tipos_itens_checklists = GTipoItemChecklist.order(:descricao)
    @g_estados_conservacao_veiculos = GEstadoConservacaoVeiculo.order(:descricao)
  end

  def set_g_checklist_veiculo
    @g_checklist_veiculo = GChecklistVeiculo.find_by(id: params[:id])
    redirect_to g_checklists_veiculos_path, alert: t("messages.not_found") unless @g_checklist_veiculo
  end

  def g_checklist_veiculo_params
    permitted_attributes = GChecklistVeiculo.column_names.reject do |col|
      %w[deleted_at created_by updated_by created_at updated_at].include?(col)
    end

    params.require(:g_checklist_veiculo).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_checklists_veiculos_path, alert: t("messages.not_found")
  end
end
