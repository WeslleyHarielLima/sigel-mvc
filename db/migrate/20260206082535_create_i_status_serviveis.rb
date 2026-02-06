# frozen_string_literal: true

class CreateIStatusServiveis < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:i_status_serviveis)
      create_table :i_status_serviveis do |t|
      t.string :descricao
      t.string :created_by
      t.string :updated_by
      t.datetime :deleted_at
      t.timestamps
      end
    end
  end

  def down
    drop_table :i_status_serviveis if table_exists?(:i_status_serviveis)
  end
end
