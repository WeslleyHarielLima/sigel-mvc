# frozen_string_literal: true

class GVeiculosController < ApplicationController
  include Pagy::Backend

  before_action :set_g_veiculo, only: %i[show edit update destroy]

  def index
    @q = GVeiculo.ransack(params[:q])
    @pagy, @g_veiculos = pagy(@q.result.includes(:g_tipo_veiculo).order(created_at: :desc))
  end

  def show
  end

  def new
    @g_veiculo = GVeiculo.new
  end

  def edit
  end

  def create
    @g_veiculo = GVeiculo.new(g_veiculo_params)

    if @g_veiculo.save
      redirect_to g_veiculos_path, notice: "Veículo criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_veiculo.update(g_veiculo_params)
      redirect_to g_veiculos_path, notice: "Veículo atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @g_veiculo.discard
    redirect_to g_veiculos_path, notice: "Veículo excluído com sucesso."
  end

  private

  def set_g_veiculo
    @g_veiculo = GVeiculo.find(params[:id])
  end

  def g_veiculo_params
    params.require(:g_veiculo).permit(
      :numero_interno, :placa, :chassi, :renavam, :marca, :modelo,
      :ano, :cor, :motor, :tombamento, :apto, :status, :g_tipo_veiculo_id
    )
  end
end
