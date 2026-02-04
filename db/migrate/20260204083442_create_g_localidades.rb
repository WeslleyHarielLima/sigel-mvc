# frozen_string_literal: true

class CreateGLocalidades < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:g_localidades)
      create_table :g_localidades do |t|
        t.string :descricao
        t.references :g_distrito, null: false, foreign_key: true

        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :g_localidades if table_exists?(:g_localidades)
  end
end
