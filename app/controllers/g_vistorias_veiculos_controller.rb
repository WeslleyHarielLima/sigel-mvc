# frozen_string_literal: true

class GVistoriasVeiculosController < ApplicationController
  before_action :set_g_vistoria_veiculo, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GVistoriaVeiculo.ransack(params[:q])
    @pagy, @g_vistorias_veiculos = pagy(@q.result)
  end

  def new
    @g_vistoria_veiculo = GVistoriaVeiculo.new
  end

  def edit
  end

  def create
    @g_vistoria_veiculo = GVistoriaVeiculo.new(g_vistoria_veiculo_params)
    @g_vistoria_veiculo.user_id_responsavel = current_user.id

    if @g_vistoria_veiculo.save
      redirect_to g_vistorias_veiculos_path, notice: t("messages.created_successfully")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_vistoria_veiculo.update(g_vistoria_veiculo_params)
      redirect_to g_vistorias_veiculos_path, notice: t("messages.updated_successfully"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_vistoria_veiculo.destroy
      redirect_to g_vistorias_veiculos_url, notice: t("messages.deleted_successfully")
    else
      redirect_to g_vistorias_veiculos_url, alert: t("messages.delete_failed_due_to_dependencies")
    end
  end

  private

  def set_g_vistoria_veiculo
    @g_vistoria_veiculo = GVistoriaVeiculo.find_by(id: params[:id])
    redirect_to g_vistorias_veiculos_path, alert: t("messages.not_found") unless @g_vistoria_veiculo
  end

  def g_vistoria_veiculo_params
    permitted_attributes = GVistoriaVeiculo.column_names.reject { |col| [ "deleted_at", "created_by", "updated_by" ].include?(col) }
    params.require(:g_vistoria_veiculo).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_vistorias_veiculos_path, alert: t("messages.not_found")
  end
end
