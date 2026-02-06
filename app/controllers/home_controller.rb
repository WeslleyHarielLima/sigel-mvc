class HomeController < ApplicationController
  def index
    @g_veiculos = GVeiculo.includes(:g_status_veiculo, :g_marca_veiculo)
  end
end
