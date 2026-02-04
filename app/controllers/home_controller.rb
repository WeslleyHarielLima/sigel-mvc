class HomeController < ApplicationController
  def index
    @g_veiculos = GVeiculo.all
  end
end
