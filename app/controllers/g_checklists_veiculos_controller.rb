# frozen_string_literal: true
class GChecklistsVeiculosController < ApplicationController
  before_action :set_g_checklist_veiculo, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GChecklistVeiculo.ransack(params[:q])
    @pagy, @g_checklists_veiculos = pagy(@q.result)
  end

  def new
    @g_checklist_veiculo = GChecklistVeiculo.new
  end

  def edit
  end

  def create
    @g_checklist_veiculo = GChecklistVeiculo.new(g_checklist_veiculo_params)

    if @g_checklist_veiculo.save
      redirect_to g_checklists_veiculos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_checklist_veiculo.update(g_checklist_veiculo_params)
      redirect_to g_checklists_veiculos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_checklist_veiculo.destroy
      redirect_to g_checklists_veiculos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_checklists_veiculos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_checklist_veiculo
    @g_checklist_veiculo = GChecklistVeiculo.find_by(id: params[:id])
    return redirect_to g_checklists_veiculos_path, alert: t('messages.not_found') unless @g_checklist_veiculo
  end

  def g_checklist_veiculo_params
    permitted_attributes = GChecklistVeiculo.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_checklist_veiculo).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_checklists_veiculos_path, alert: t('messages.not_found')
  end
end
