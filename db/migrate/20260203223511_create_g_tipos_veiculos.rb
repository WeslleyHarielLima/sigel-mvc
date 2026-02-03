class CreateGTiposVeiculos < ActiveRecord::Migration[8.1]
  def change
    create_table :g_tipos_veiculos do |t|
      t.string :descricao, null: false
      t.datetime :discarded_at

      t.timestamps
    end
    add_index :g_tipos_veiculos, :discarded_at
    add_index :g_tipos_veiculos, :descricao
  end
end
