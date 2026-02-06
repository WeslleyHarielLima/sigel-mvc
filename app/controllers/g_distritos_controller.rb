# frozen_string_literal: true
class GDistritosController < ApplicationController
  before_action :set_g_distrito, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GDistrito.ransack(params[:q])
    @pagy, @g_distritos = pagy(@q.result)
  end

  def new
    @g_distrito = GDistrito.new
  end

  def edit
  end

  def create
    @g_distrito = GDistrito.new(g_distrito_params)

    if @g_distrito.save
      redirect_to g_distritos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_distrito.update(g_distrito_params)
      redirect_to g_distritos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_distrito.destroy
      redirect_to g_distritos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_distritos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_distrito
    @g_distrito = GDistrito.find_by(id: params[:id])
    return redirect_to g_distritos_path, alert: t('messages.not_found') unless @g_distrito
  end

  def g_distrito_params
    permitted_attributes = GDistrito.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_distrito).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_distritos_path, alert: t('messages.not_found')
  end
end
