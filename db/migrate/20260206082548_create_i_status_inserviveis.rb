# frozen_string_literal: true

class CreateIStatusInserviveis < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:i_status_inserviveis)
      create_table :i_status_inserviveis do |t|
      t.string :descricao
      t.string :created_by
      t.string :updated_by
      t.datetime :deleted_at
      t.timestamps
      end
    end
  end

  def down
    drop_table :i_status_inserviveis if table_exists?(:i_status_inserviveis)
  end
end
