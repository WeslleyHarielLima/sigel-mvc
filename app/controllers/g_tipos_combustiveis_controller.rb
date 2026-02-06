# frozen_string_literal: true
class GTiposCombustiveisController < ApplicationController
  before_action :set_g_tipo_combustivel, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GTipoCombustivel.ransack(params[:q])
    @pagy, @g_tipos_combustiveis = pagy(@q.result)
  end

  def new
    @g_tipo_combustivel = GTipoCombustivel.new
  end

  def edit
  end

  def create
    @g_tipo_combustivel = GTipoCombustivel.new(g_tipo_combustivel_params)

    if @g_tipo_combustivel.save
      redirect_to g_tipos_combustiveis_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_tipo_combustivel.update(g_tipo_combustivel_params)
      redirect_to g_tipos_combustiveis_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_tipo_combustivel.destroy
      redirect_to g_tipos_combustiveis_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_tipos_combustiveis_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_tipo_combustivel
    @g_tipo_combustivel = GTipoCombustivel.find_by(id: params[:id])
    return redirect_to g_tipos_combustiveis_path, alert: t('messages.not_found') unless @g_tipo_combustivel
  end

  def g_tipo_combustivel_params
    permitted_attributes = GTipoCombustivel.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_tipo_combustivel).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_tipos_combustiveis_path, alert: t('messages.not_found')
  end
end
