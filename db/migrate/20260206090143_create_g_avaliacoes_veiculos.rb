# frozen_string_literal: true

class CreateGAvaliacoesVeiculos < ActiveRecord::Migration[7.2]
  def up
    create_table :g_avaliacoes_veiculos do |t|
      t.references :g_veiculo, null: false, foreign_key: true
      t.decimal :valor_mercado,          precision: 17, scale: 2
      t.decimal :valor_referencia_fipe,  precision: 17, scale: 2
      t.decimal :percentual_depreciacao, precision: 5, scale: 2
      t.decimal :valor_depreciado,       precision: 17, scale: 2
      t.decimal :valor_inicial_lance,    precision: 17, scale: 2
      t.decimal :pontuacao_checklist,    precision: 5, scale: 2
      t.bigint :user_id_avaliador, null: false
      t.datetime :avaliado_em

      t.string :created_by
      t.string :updated_by
      t.datetime :deleted_at
      t.timestamps
    end

    add_index :g_avaliacoes_veiculos, :deleted_at
    add_index :g_avaliacoes_veiculos, :user_id_avaliador

    add_foreign_key :g_avaliacoes_veiculos, :users, column: :user_id_avaliador
  end

  def down
    drop_table :g_avaliacoes_veiculos
  end
end
