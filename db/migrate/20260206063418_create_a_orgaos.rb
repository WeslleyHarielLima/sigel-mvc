# frozen_string_literal: true

class CreateAOrgaos < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:a_orgaos)
      create_table :a_orgaos do |t|
      t.string :descricao
      t.string :created_by
      t.string :updated_by
      t.datetime :deleted_at
      t.timestamps
      end
    end
  end

  def down
    drop_table :a_orgaos if table_exists?(:a_orgaos)
  end
end
