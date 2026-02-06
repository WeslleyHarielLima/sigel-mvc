# frozen_string_literal: true

class CreateATiposUsuarios < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:a_tipos_usuarios)
      create_table :a_tipos_usuarios do |t|
      t.string :descricao
      t.string :created_by
      t.string :updated_by
      t.datetime :deleted_at
      t.timestamps
      end
    end
  end

  def down
    drop_table :a_tipos_usuarios if table_exists?(:a_tipos_usuarios)
  end
end
