# app/models/g_marca_veiculo.rb
class GMarcaVeiculo < ApplicationRecord
  has_many :g_veiculos
end
