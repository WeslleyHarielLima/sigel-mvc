# frozen_string_literal: true

class AddSituacaoAdministrativaAndLocalizacaoFisicaToGVeiculos < ActiveRecord::Migration[7.2]
  def up
    unless column_exists?(:g_veiculos, :situacao_administrativa)
      add_column :g_veiculos, :situacao_administrativa, :string
      add_index  :g_veiculos, :situacao_administrativa
    end

    unless column_exists?(:g_veiculos, :localizacao_fisica)
      add_column :g_veiculos, :localizacao_fisica, :string
      add_index  :g_veiculos, :localizacao_fisica
    end
  end

  def down
    if column_exists?(:g_veiculos, :situacao_administrativa)
      remove_index  :g_veiculos, :situacao_administrativa rescue nil
      remove_column :g_veiculos, :situacao_administrativa
    end

    if column_exists?(:g_veiculos, :localizacao_fisica)
      remove_index  :g_veiculos, :localizacao_fisica rescue nil
      remove_column :g_veiculos, :localizacao_fisica
    end
  end
end
