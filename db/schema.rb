# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_02_06_090143) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "a_orgaos", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "a_status", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "a_tipos_usuarios", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "a_unidades", force: :cascade do |t|
    t.string "nome_fantasia"
    t.bigint "a_orgao_id", null: false
    t.string "cnpj"
    t.string "endereco"
    t.string "telefone"
    t.bigint "a_status_id", null: false
    t.string "codigo_interno"
    t.bigint "g_municipio_id", null: false
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["a_orgao_id"], name: "index_a_unidades_on_a_orgao_id"
    t.index ["a_status_id"], name: "index_a_unidades_on_a_status_id"
    t.index ["g_municipio_id"], name: "index_a_unidades_on_g_municipio_id"
  end

  create_table "g_avaliacoes_veiculos", force: :cascade do |t|
    t.bigint "g_veiculo_id", null: false
    t.decimal "valor_mercado", precision: 17, scale: 2
    t.decimal "valor_referencia_fipe", precision: 17, scale: 2
    t.decimal "percentual_depreciacao", precision: 5, scale: 2
    t.decimal "valor_depreciado", precision: 17, scale: 2
    t.decimal "valor_inicial_lance", precision: 17, scale: 2
    t.decimal "pontuacao_checklist", precision: 5, scale: 2
    t.bigint "user_id_avaliador", null: false
    t.datetime "avaliado_em"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_g_avaliacoes_veiculos_on_deleted_at"
    t.index ["g_veiculo_id"], name: "index_g_avaliacoes_veiculos_on_g_veiculo_id"
    t.index ["user_id_avaliador"], name: "index_g_avaliacoes_veiculos_on_user_id_avaliador"
  end

  create_table "g_checklists_veiculos", force: :cascade do |t|
    t.bigint "g_vistoria_veiculo_id", null: false
    t.bigint "g_tipo_item_checklist_id", null: false
    t.bigint "g_estado_conservacao_veiculo_id", null: false
    t.string "resultado"
    t.text "observacao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_g_checklists_veiculos_on_deleted_at"
    t.index ["g_estado_conservacao_veiculo_id"], name: "index_g_checklists_veiculos_on_g_estado_conservacao_veiculo_id"
    t.index ["g_tipo_item_checklist_id"], name: "index_g_checklists_veiculos_on_g_tipo_item_checklist_id"
    t.index ["g_vistoria_veiculo_id"], name: "index_g_checklists_veiculos_on_g_vistoria_veiculo_id"
  end

  create_table "g_distritos", force: :cascade do |t|
    t.string "descricao"
    t.string "codigo_ibge"
    t.bigint "g_municipio_id", null: false
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["g_municipio_id"], name: "index_g_distritos_on_g_municipio_id"
  end

  create_table "g_estados", force: :cascade do |t|
    t.string "descricao"
    t.string "uf"
    t.bigint "g_pais_id", null: false
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_g_estados_on_deleted_at"
    t.index ["g_pais_id"], name: "index_g_estados_on_g_pais_id"
    t.index ["uf"], name: "index_g_estados_on_uf", unique: true
  end

  create_table "g_estados_conservacao_veiculos", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_marcas_veiculos", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_municipios", force: :cascade do |t|
    t.string "descricao"
    t.integer "codigo_ibge"
    t.bigint "g_estado_id"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["codigo_ibge"], name: "index_g_municipios_on_codigo_ibge", unique: true
    t.index ["deleted_at"], name: "index_g_municipios_on_deleted_at"
    t.index ["g_estado_id"], name: "index_g_municipios_on_g_estado_id"
  end

  create_table "g_paises", force: :cascade do |t|
    t.string "descricao"
    t.string "sigla"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_status_leiloes_veiculos", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_status_veiculos", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_tipos_combustiveis", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_tipos_itens_checklists", force: :cascade do |t|
    t.string "descricao", null: false
    t.string "criterio_objetivo"
    t.decimal "peso", precision: 5, scale: 2, null: false
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_g_tipos_itens_checklists_on_deleted_at"
  end

  create_table "g_tipos_veiculos", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_veiculos", force: :cascade do |t|
    t.string "numero_interno"
    t.string "placa"
    t.string "chassi"
    t.string "renavam"
    t.string "modelo"
    t.integer "ano"
    t.string "cor"
    t.string "motor"
    t.string "tombamento"
    t.bigint "g_status_veiculo_id"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "g_marca_veiculo_id"
    t.bigint "g_tipo_combustivel_id", null: false
    t.string "situacao_administrativa"
    t.string "localizacao_fisica"
    t.index ["deleted_at"], name: "index_g_veiculos_on_deleted_at"
    t.index ["g_marca_veiculo_id"], name: "index_g_veiculos_on_g_marca_veiculo_id"
    t.index ["g_status_veiculo_id"], name: "index_g_veiculos_on_g_status_veiculo_id"
    t.index ["g_tipo_combustivel_id"], name: "index_g_veiculos_on_g_tipo_combustivel_id"
    t.index ["localizacao_fisica"], name: "index_g_veiculos_on_localizacao_fisica"
    t.index ["placa"], name: "index_g_veiculos_on_placa"
    t.index ["renavam"], name: "index_g_veiculos_on_renavam"
    t.index ["situacao_administrativa"], name: "index_g_veiculos_on_situacao_administrativa"
  end

  create_table "g_vistorias_veiculos", force: :cascade do |t|
    t.bigint "g_veiculo_id", null: false
    t.bigint "user_id_responsavel", null: false
    t.datetime "data_vistoria"
    t.text "observacoes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["g_veiculo_id"], name: "index_g_vistorias_veiculos_on_g_veiculo_id"
    t.index ["user_id_responsavel"], name: "index_g_vistorias_veiculos_on_user_id_responsavel"
  end

  create_table "i_status_inserviveis", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "i_status_serviveis", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "nome", null: false
    t.string "cpf", null: false
    t.string "role", default: "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "telefone"
    t.bigint "a_cargo_id"
    t.bigint "a_unidade_id"
    t.bigint "a_tipo_usuario_id"
    t.bigint "a_status_id"
    t.string "created_by"
    t.string "banco"
    t.string "agencia"
    t.string "conta"
    t.string "chave_pix"
    t.index ["a_cargo_id"], name: "index_users_on_a_cargo_id"
    t.index ["a_status_id"], name: "index_users_on_a_status_id"
    t.index ["a_tipo_usuario_id"], name: "index_users_on_a_tipo_usuario_id"
    t.index ["a_unidade_id"], name: "index_users_on_a_unidade_id"
    t.index ["cpf"], name: "index_users_on_cpf", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "a_unidades", "a_orgaos"
  add_foreign_key "a_unidades", "a_status"
  add_foreign_key "a_unidades", "g_municipios"
  add_foreign_key "g_avaliacoes_veiculos", "g_veiculos"
  add_foreign_key "g_avaliacoes_veiculos", "users", column: "user_id_avaliador"
  add_foreign_key "g_checklists_veiculos", "g_estados_conservacao_veiculos"
  add_foreign_key "g_checklists_veiculos", "g_tipos_itens_checklists"
  add_foreign_key "g_checklists_veiculos", "g_vistorias_veiculos"
  add_foreign_key "g_distritos", "g_municipios"
  add_foreign_key "g_estados", "g_paises"
  add_foreign_key "g_municipios", "g_estados"
  add_foreign_key "g_veiculos", "g_marcas_veiculos"
  add_foreign_key "g_veiculos", "g_status_veiculos"
  add_foreign_key "g_veiculos", "g_tipos_combustiveis"
  add_foreign_key "g_vistorias_veiculos", "g_veiculos"
  add_foreign_key "g_vistorias_veiculos", "users", column: "user_id_responsavel"
end
