# frozen_string_literal: true

class CreateGTiposVeiculos < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:g_tipos_veiculos)
      create_table :g_tipos_veiculos do |t|
      t.string :descricao
      t.string :created_by
      t.string :updated_by
      t.datetime :deleted_at
      t.timestamps
      end
    end
  end

  def down
    drop_table :g_tipos_veiculos if table_exists?(:g_tipos_veiculos)
  end
end
