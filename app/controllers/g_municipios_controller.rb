# frozen_string_literal: true
class GMunicipiosController < ApplicationController
  before_action :set_g_municipio, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GMunicipio.ransack(params[:q])
    @pagy, @g_municipios = pagy(@q.result)
  end

  def new
    @g_municipio = GMunicipio.new
  end

  def edit
  end

  def create
    @g_municipio = GMunicipio.new(g_municipio_params)

    if @g_municipio.save
      redirect_to g_municipios_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_municipio.update(g_municipio_params)
      redirect_to g_municipios_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_municipio.destroy
      redirect_to g_municipios_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_municipios_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_municipio
    @g_municipio = GMunicipio.find_by(id: params[:id])
    return redirect_to g_municipios_path, alert: t('messages.not_found') unless @g_municipio
  end

  def g_municipio_params
    permitted_attributes = GMunicipio.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_municipio).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_municipios_path, alert: t('messages.not_found')
  end
end
