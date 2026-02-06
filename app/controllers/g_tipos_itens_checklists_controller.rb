# frozen_string_literal: true
class GTiposItensChecklistsController < ApplicationController
  before_action :set_g_tipo_item_checklist, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GTipoItemChecklist.ransack(params[:q])
    @pagy, @g_tipos_itens_checklists = pagy(@q.result)
  end

  def new
    @g_tipo_item_checklist = GTipoItemChecklist.new
  end

  def edit
  end

  def create
    @g_tipo_item_checklist = GTipoItemChecklist.new(g_tipo_item_checklist_params)

    if @g_tipo_item_checklist.save
      redirect_to g_tipos_itens_checklists_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_tipo_item_checklist.update(g_tipo_item_checklist_params)
      redirect_to g_tipos_itens_checklists_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_tipo_item_checklist.destroy
      redirect_to g_tipos_itens_checklists_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_tipos_itens_checklists_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_tipo_item_checklist
    @g_tipo_item_checklist = GTipoItemChecklist.find_by(id: params[:id])
    return redirect_to g_tipos_itens_checklists_path, alert: t('messages.not_found') unless @g_tipo_item_checklist
  end

  def g_tipo_item_checklist_params
    permitted_attributes = GTipoItemChecklist.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_tipo_item_checklist).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_tipos_itens_checklists_path, alert: t('messages.not_found')
  end
end
