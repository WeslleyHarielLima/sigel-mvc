class CreateGVeiculos < ActiveRecord::Migration[7.2]
  def change
    create_table :g_veiculos do |t|
      t.string :numero_interno
      t.string :placa
      t.string :chassi
      t.string :renavam
      t.string :marca
      t.string :modelo
      t.integer :ano
      t.string :cor
      t.string :motor
      t.string :tombamento
      t.boolean :apto, default: false
      t.string :status, default: 'pendente'
      t.references :g_tipo_veiculo, null: false, foreign_key: { to_table: :g_tipos_veiculos }
      t.datetime :discarded_at

      t.timestamps
    end

    add_index :g_veiculos, :discarded_at
    add_index :g_veiculos, :status
    add_index :g_veiculos, :placa
  end
end
