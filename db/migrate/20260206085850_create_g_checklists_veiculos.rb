# frozen_string_literal: true

class CreateGChecklistsVeiculos < ActiveRecord::Migration[7.2]
  def up
    create_table :g_checklists_veiculos do |t|
      t.references :g_vistoria_veiculo,              null: false, foreign_key: true
      t.references :g_tipo_item_checklist_veiculo,   null: false, foreign_key: true
      t.references :g_estado_conservacao_veiculo,    null: false, foreign_key: true
      t.string :resultado
      t.text :observacao

      t.string :created_by
      t.string :updated_by
      t.datetime :deleted_at
      t.timestamps
    end

    add_index :g_checklists_veiculos, :deleted_at
  end

  def down
    drop_table :g_checklists_veiculos
  end
end
