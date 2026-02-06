# frozen_string_literal: true
class IStatusInserviveisController < ApplicationController
  before_action :set_i_status_inservivel, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = IStatusInservivel.ransack(params[:q])
    @pagy, @i_status_inserviveis = pagy(@q.result)
  end

  def new
    @i_status_inservivel = IStatusInservivel.new
  end

  def edit
  end

  def create
    @i_status_inservivel = IStatusInservivel.new(i_status_inservivel_params)

    if @i_status_inservivel.save
      redirect_to i_status_inserviveis_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @i_status_inservivel.update(i_status_inservivel_params)
      redirect_to i_status_inserviveis_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @i_status_inservivel.destroy
      redirect_to i_status_inserviveis_url, notice: t('messages.deleted_successfully')
    else
      redirect_to i_status_inserviveis_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_i_status_inservivel
    @i_status_inservivel = IStatusInservivel.find_by(id: params[:id])
    return redirect_to i_status_inserviveis_path, alert: t('messages.not_found') unless @i_status_inservivel
  end

  def i_status_inservivel_params
    permitted_attributes = IStatusInservivel.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:i_status_inservivel).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to i_status_inserviveis_path, alert: t('messages.not_found')
  end
end
