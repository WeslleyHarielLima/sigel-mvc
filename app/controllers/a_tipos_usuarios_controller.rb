# frozen_string_literal: true
class ATiposUsuariosController < ApplicationController
  before_action :set_a_tipo_usuario, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = ATipoUsuario.ransack(params[:q])
    @pagy, @a_tipos_usuarios = pagy(@q.result)
  end

  def new
    @a_tipo_usuario = ATipoUsuario.new
  end

  def edit
  end

  def create
    @a_tipo_usuario = ATipoUsuario.new(a_tipo_usuario_params)

    if @a_tipo_usuario.save
      redirect_to a_tipos_usuarios_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @a_tipo_usuario.update(a_tipo_usuario_params)
      redirect_to a_tipos_usuarios_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @a_tipo_usuario.destroy
      redirect_to a_tipos_usuarios_url, notice: t('messages.deleted_successfully')
    else
      redirect_to a_tipos_usuarios_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_a_tipo_usuario
    @a_tipo_usuario = ATipoUsuario.find_by(id: params[:id])
    return redirect_to a_tipos_usuarios_path, alert: t('messages.not_found') unless @a_tipo_usuario
  end

  def a_tipo_usuario_params
    permitted_attributes = ATipoUsuario.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:a_tipo_usuario).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to a_tipos_usuarios_path, alert: t('messages.not_found')
  end
end
