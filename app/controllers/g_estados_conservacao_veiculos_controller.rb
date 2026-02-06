# frozen_string_literal: true
class GEstadosConservacaoVeiculosController < ApplicationController
  before_action :set_g_estado_conservacao_veiculo, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GEstadoConservacaoVeiculo.ransack(params[:q])
    @pagy, @g_estados_conservacao_veiculos = pagy(@q.result)
  end

  def new
    @g_estado_conservacao_veiculo = GEstadoConservacaoVeiculo.new
  end

  def edit
  end

  def create
    @g_estado_conservacao_veiculo = GEstadoConservacaoVeiculo.new(g_estado_conservacao_veiculo_params)

    if @g_estado_conservacao_veiculo.save
      redirect_to g_estados_conservacao_veiculos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_estado_conservacao_veiculo.update(g_estado_conservacao_veiculo_params)
      redirect_to g_estados_conservacao_veiculos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_estado_conservacao_veiculo.destroy
      redirect_to g_estados_conservacao_veiculos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_estados_conservacao_veiculos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_estado_conservacao_veiculo
    @g_estado_conservacao_veiculo = GEstadoConservacaoVeiculo.find_by(id: params[:id])
    return redirect_to g_estados_conservacao_veiculos_path, alert: t('messages.not_found') unless @g_estado_conservacao_veiculo
  end

  def g_estado_conservacao_veiculo_params
    permitted_attributes = GEstadoConservacaoVeiculo.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_estado_conservacao_veiculo).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_estados_conservacao_veiculos_path, alert: t('messages.not_found')
  end
end
