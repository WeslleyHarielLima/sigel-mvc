# frozen_string_literal: true

class CreateAUnidades < ActiveRecord::Migration[7.2]
  def up
    create_table :a_unidades do |t|
      t.string :nome_fantasia
      t.references :a_orgao,     null: false, foreign_key: true
      t.string  :cnpj
      t.string  :endereco
      t.string  :telefone
      t.references :a_status,    null: false, foreign_key: true
      t.string :codigo_interno
      t.references :g_municipio, null: false, foreign_key: true

      t.string   :created_by
      t.string   :updated_by
      t.datetime :deleted_at

      t.timestamps
    end
  end

  def down
    drop_table :a_unidades
  end
end
