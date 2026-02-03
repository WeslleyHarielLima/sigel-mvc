# frozen_string_literal: true

class GTiposVeiculosController < ApplicationController
  include Pagy::Backend

  before_action :set_g_tipo_veiculo, only: %i[show edit update destroy]

  def index
    @pagy, @g_tipos_veiculos = pagy(GTipoVeiculo.order(:descricao))
  end

  def show
  end

  def new
    @g_tipo_veiculo = GTipoVeiculo.new
  end

  def edit
  end

  def create
    @g_tipo_veiculo = GTipoVeiculo.new(g_tipo_veiculo_params)

    if @g_tipo_veiculo.save
      redirect_to g_tipos_veiculos_path, notice: "Tipo de veículo criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_tipo_veiculo.update(g_tipo_veiculo_params)
      redirect_to g_tipos_veiculos_path, notice: "Tipo de veículo atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_tipo_veiculo.g_veiculos.any?
      redirect_to g_tipos_veiculos_path, alert: "Não é possível excluir este tipo pois existem veículos associados."
    else
      @g_tipo_veiculo.discard
      redirect_to g_tipos_veiculos_path, notice: "Tipo de veículo excluído com sucesso."
    end
  end

  private

  def set_g_tipo_veiculo
    @g_tipo_veiculo = GTipoVeiculo.find(params[:id])
  end

  def g_tipo_veiculo_params
    params.require(:g_tipo_veiculo).permit(:descricao)
  end
end
