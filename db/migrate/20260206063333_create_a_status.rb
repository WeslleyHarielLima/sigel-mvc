# frozen_string_literal: true

class CreateAStatus < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:a_status)
      create_table :a_status do |t|
      t.string :descricao

      t.string :created_by
      t.string :updated_by
      t.datetime :deleted_at
      t.timestamps
      end
    end
  end

  def down
    drop_table :a_status if table_exists?(:a_status)
  end
end
