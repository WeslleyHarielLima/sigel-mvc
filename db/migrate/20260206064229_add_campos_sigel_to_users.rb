# frozen_string_literal: true

class AddCamposSigelToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :telefone, :string unless column_exists?(:users, :telefone)

    add_column :users, :a_cargo_id, :bigint unless column_exists?(:users, :a_cargo_id)
    add_column :users, :a_unidade_id, :bigint unless column_exists?(:users, :a_unidade_id)

    # NÃO coloca null: false agora
    add_column :users, :a_tipo_usuario_id, :bigint unless column_exists?(:users, :a_tipo_usuario_id)
    add_column :users, :a_status_id, :bigint unless column_exists?(:users, :a_status_id)


    add_column :users, :created_by, :string unless column_exists?(:users, :created_by)
    add_column :users, :banco,      :string unless column_exists?(:users, :banco)
    add_column :users, :agencia,    :string unless column_exists?(:users, :agencia)
    add_column :users, :conta,      :string unless column_exists?(:users, :conta)
    add_column :users, :chave_pix,  :string unless column_exists?(:users, :chave_pix)

    add_index :users, :a_cargo_id unless index_exists?(:users, :a_cargo_id)
    add_index :users, :a_unidade_id unless index_exists?(:users, :a_unidade_id)
    add_index :users, :a_tipo_usuario_id unless index_exists?(:users, :a_tipo_usuario_id)
    add_index :users, :a_status_id unless index_exists?(:users, :a_status_id)
  end
end
