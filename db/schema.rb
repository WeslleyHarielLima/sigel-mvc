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

ActiveRecord::Schema[7.2].define(version: 2026_02_03_223535) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "g_tipos_veiculos", force: :cascade do |t|
    t.string "descricao", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["descricao"], name: "index_g_tipos_veiculos_on_descricao"
    t.index ["discarded_at"], name: "index_g_tipos_veiculos_on_discarded_at"
  end

  create_table "g_veiculos", force: :cascade do |t|
    t.string "numero_interno"
    t.string "placa"
    t.string "chassi"
    t.string "renavam"
    t.string "marca"
    t.string "modelo"
    t.integer "ano"
    t.string "cor"
    t.string "motor"
    t.string "tombamento"
    t.boolean "apto", default: false
    t.string "status", default: "pendente"
    t.bigint "g_tipo_veiculo_id", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_g_veiculos_on_discarded_at"
    t.index ["g_tipo_veiculo_id"], name: "index_g_veiculos_on_g_tipo_veiculo_id"
    t.index ["placa"], name: "index_g_veiculos_on_placa"
    t.index ["status"], name: "index_g_veiculos_on_status"
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
    t.index ["cpf"], name: "index_users_on_cpf", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "g_veiculos", "g_tipos_veiculos", column: "g_tipo_veiculo_id"
end
