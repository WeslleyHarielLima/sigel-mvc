# frozen_string_literal: true

class CreateGTiposItensChecklists < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:g_tipos_itens_checklists)
      create_table :g_tipos_itens_checklists do |t|
      t.string  :descricao, null: false
      t.string  :criterio_objetivo
      t.decimal :peso, precision: 5, scale: 2, null: false

      t.string  :created_by
      t.string  :updated_by
      t.datetime :deleted_at
      t.timestamps
      end

      add_index :g_tipos_itens_checklists, :deleted_at
    end
  end

  def down
    drop_table :g_tipos_itens_checklists if table_exists?(:g_tipos_itens_checklists)
  end
end
