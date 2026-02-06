# frozen_string_literal: true
class GMarcasVeiculosController < ApplicationController
  before_action :set_g_marca_veiculo, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GMarcaVeiculo.ransack(params[:q])
    @pagy, @g_marcas_veiculos = pagy(@q.result)
  end

  def new
    @g_marca_veiculo = GMarcaVeiculo.new
  end

  def edit
  end

  def create
    @g_marca_veiculo = GMarcaVeiculo.new(g_marca_veiculo_params)

    if @g_marca_veiculo.save
      redirect_to g_marcas_veiculos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_marca_veiculo.update(g_marca_veiculo_params)
      redirect_to g_marcas_veiculos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_marca_veiculo.destroy
      redirect_to g_marcas_veiculos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_marcas_veiculos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_marca_veiculo
    @g_marca_veiculo = GMarcaVeiculo.find_by(id: params[:id])
    return redirect_to g_marcas_veiculos_path, alert: t('messages.not_found') unless @g_marca_veiculo
  end

  def g_marca_veiculo_params
    permitted_attributes = GMarcaVeiculo.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_marca_veiculo).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_marcas_veiculos_path, alert: t('messages.not_found')
  end
end
