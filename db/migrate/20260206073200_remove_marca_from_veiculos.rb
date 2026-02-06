# frozen_string_literal: true

class RemoveMarcaFromVeiculos < ActiveRecord::Migration[7.2]
  def change
    remove_column :g_veiculos, :marca, :string if column_exists?(:g_veiculos, :marca)
  end
end
