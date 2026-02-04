# frozen_string_literal: true
class GLocalidadesController < ApplicationController
  before_action :set_g_localidade, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GLocalidade.ransack(params[:q])
    @pagy, @g_localidades = pagy(@q.result)
  end

  def new
    @g_localidade = GLocalidade.new
  end

  def edit
  end

  def create
    @g_localidade = GLocalidade.new(g_localidade_params)

    if @g_localidade.save
      redirect_to g_localidades_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_localidade.update(g_localidade_params)
      redirect_to g_localidades_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_localidade.destroy
      redirect_to g_localidades_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_localidades_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_localidade
    @g_localidade = GLocalidade.find_by(id: params[:id])
    return redirect_to g_localidades_path, alert: t('messages.not_found') unless @g_localidade
  end

  def g_localidade_params
    permitted_attributes = GLocalidade.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_localidade).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_localidades_path, alert: t('messages.not_found')
  end
end
