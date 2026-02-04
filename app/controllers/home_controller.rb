class HomeController < ApplicationController
  def index
    @g_veiculos = defined?(GVeiculo) ? GVeiculo.all : []
  end
end
