# frozen_string_literal: true
class IStatusServiveisController < ApplicationController
  before_action :set_i_status_servivel, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = IStatusServivel.ransack(params[:q])
    @pagy, @i_status_serviveis = pagy(@q.result)
  end

  def new
    @i_status_servivel = IStatusServivel.new
  end

  def edit
  end

  def create
    @i_status_servivel = IStatusServivel.new(i_status_servivel_params)

    if @i_status_servivel.save
      redirect_to i_status_serviveis_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @i_status_servivel.update(i_status_servivel_params)
      redirect_to i_status_serviveis_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @i_status_servivel.destroy
      redirect_to i_status_serviveis_url, notice: t('messages.deleted_successfully')
    else
      redirect_to i_status_serviveis_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_i_status_servivel
    @i_status_servivel = IStatusServivel.find_by(id: params[:id])
    return redirect_to i_status_serviveis_path, alert: t('messages.not_found') unless @i_status_servivel
  end

  def i_status_servivel_params
    permitted_attributes = IStatusServivel.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:i_status_servivel).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to i_status_serviveis_path, alert: t('messages.not_found')
  end
end
