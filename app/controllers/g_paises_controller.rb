# frozen_string_literal: true
class GPaisesController < ApplicationController
  before_action :set_g_pais, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GPais.ransack(params[:q])
    @pagy, @g_paises = pagy(@q.result)
  end

  def new
    @g_pais = GPais.new
  end

  def edit
  end

  def create
    @g_pais = GPais.new(g_pais_params)

    if @g_pais.save
      redirect_to g_paises_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_pais.update(g_pais_params)
      redirect_to g_paises_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_pais.destroy
      redirect_to g_paises_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_paises_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_pais
    @g_pais = GPais.find_by(id: params[:id])
    return redirect_to g_paises_path, alert: t('messages.not_found') unless @g_pais
  end

  def g_pais_params
    permitted_attributes = GPais.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_pais).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_paises_path, alert: t('messages.not_found')
  end
end
