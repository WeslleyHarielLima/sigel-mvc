class AddTipoCombustivelToGVeiculos < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:g_veiculos, :g_tipo_combustivel_id)
      add_reference :g_veiculos, :g_tipo_combustivel, null: false, foreign_key: { to_table: :g_tipos_combustiveis }
    end
  end
end
