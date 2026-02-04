# frozen_string_literal: true
class GEstadosController < ApplicationController
  before_action :set_g_estado, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GEstado.ransack(params[:q])
    @pagy, @g_estados = pagy(@q.result)
  end

  def new
    @g_estado = GEstado.new
  end

  def edit
  end

  def create
    @g_estado = GEstado.new(g_estado_params)

    if @g_estado.save
      redirect_to g_estados_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_estado.update(g_estado_params)
      redirect_to g_estados_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_estado.destroy
      redirect_to g_estados_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_estados_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_estado
    @g_estado = GEstado.find_by(id: params[:id])
    return redirect_to g_estados_path, alert: t('messages.not_found') unless @g_estado
  end

  def g_estado_params
    permitted_attributes = GEstado.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_estado).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_estados_path, alert: t('messages.not_found')
  end
end
