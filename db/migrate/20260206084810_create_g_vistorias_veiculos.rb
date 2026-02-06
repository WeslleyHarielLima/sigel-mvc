class CreateGVistoriasVeiculos < ActiveRecord::Migration[7.2]
  def up
    create_table :g_vistorias_veiculos, if_not_exists: true do |t|
      t.bigint :g_veiculo_id,        null: false
      t.bigint :user_id_responsavel, null: false

      t.datetime :data_vistoria
      t.text :observacoes

      t.timestamps
    end

    # Índices
    add_index :g_vistorias_veiculos, :g_veiculo_id,        if_not_exists: true
    add_index :g_vistorias_veiculos, :user_id_responsavel, if_not_exists: true

    # FKs
    add_foreign_key :g_vistorias_veiculos, :g_veiculos, column: :g_veiculo_id
    add_foreign_key :g_vistorias_veiculos, :users, column: :user_id_responsavel
  end

  def down
    remove_foreign_key :g_vistorias_veiculos, column: :g_veiculo_id rescue nil
    remove_foreign_key :g_vistorias_veiculos, column: :user_id_responsavel rescue nil

    drop_table :g_vistorias_veiculos, if_exists: true
  end
end
