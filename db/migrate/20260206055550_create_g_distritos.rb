# frozen_string_literal: true

class CreateGDistritos < ActiveRecord::Migration[7.2]
  def up
    create_table :g_distritos do |t|
      t.string :descricao
      t.string :codigo_ibge
      t.references :g_municipio, null: false, foreign_key: true
      t.string :created_by
      t.string :updated_by
      t.datetime :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :g_distritos
  end
end
