# frozen_string_literal: true
class AOrgaosController < ApplicationController
  before_action :set_a_orgao, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = AOrgao.ransack(params[:q])
    @pagy, @a_orgaos = pagy(@q.result)
  end

  def new
    @a_orgao = AOrgao.new
  end

  def edit
  end

  def create
    @a_orgao = AOrgao.new(a_orgao_params)

    if @a_orgao.save
      redirect_to a_orgaos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @a_orgao.update(a_orgao_params)
      redirect_to a_orgaos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @a_orgao.destroy
      redirect_to a_orgaos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to a_orgaos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_a_orgao
    @a_orgao = AOrgao.find_by(id: params[:id])
    return redirect_to a_orgaos_path, alert: t('messages.not_found') unless @a_orgao
  end

  def a_orgao_params
    permitted_attributes = AOrgao.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:a_orgao).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to a_orgaos_path, alert: t('messages.not_found')
  end
end
