# frozen_string_literal: true

class AddMarcaToVeiculos < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:g_veiculos, :g_marca_veiculo_id)
      add_reference :g_veiculos, :g_marca_veiculo, foreign_key: true, index: true
    end
  end
end
