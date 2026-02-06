# frozen_string_literal: true
class AStatusController < ApplicationController
  before_action :set_a_status, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = AStatus.ransack(params[:q])
    @pagy, @a_status = pagy(@q.result)
  end

  def new
    @a_status = AStatus.new
  end

  def edit
  end

  def create
    @a_status = AStatus.new(a_status_params)

    if @a_status.save
      redirect_to a_status_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @a_status.update(a_status_params)
      redirect_to a_status_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @a_status.destroy
      redirect_to a_status_url, notice: t('messages.deleted_successfully')
    else
      redirect_to a_status_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_a_status
    @a_status = AStatus.find_by(id: params[:id])
    return redirect_to a_status_path, alert: t('messages.not_found') unless @a_status
  end

  def a_status_params
    permitted_attributes = AStatus.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:a_status).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to a_status_path, alert: t('messages.not_found')
  end
end
