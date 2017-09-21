# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170921100224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acoes", force: :cascade do |t|
    t.bigint "pessoa_id"
    t.bigint "user_id"
    t.string "tipo_acao"
    t.string "assunto"
    t.date "agendamento"
    t.string "descricao"
    t.text "observacao"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pessoa_id"], name: "index_acoes_on_pessoa_id"
    t.index ["user_id"], name: "index_acoes_on_user_id"
  end

  create_table "bairros", force: :cascade do |t|
    t.string "nome"
    t.bigint "cidade_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cidade_id"], name: "index_bairros_on_cidade_id"
  end

  create_table "carros", force: :cascade do |t|
    t.string "nome"
    t.string "cor"
    t.string "placa"
    t.text "observacoes"
    t.bigint "pessoa_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pessoa_id"], name: "index_carros_on_pessoa_id"
    t.index ["user_id"], name: "index_carros_on_user_id"
  end

  create_table "cidades", force: :cascade do |t|
    t.string "nome"
    t.bigint "municipio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["municipio_id"], name: "index_cidades_on_municipio_id"
  end

  create_table "estados", force: :cascade do |t|
    t.string "nome"
    t.string "sigla"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "funcoes", force: :cascade do |t|
    t.string "nome"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_funcoes_on_user_id"
  end

  create_table "municipios", force: :cascade do |t|
    t.string "nome"
    t.bigint "estado_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estado_id"], name: "index_municipios_on_estado_id"
  end

  create_table "pessoas", force: :cascade do |t|
    t.string "nome", null: false
    t.string "endereco", null: false
    t.bigint "cidade_id"
    t.bigint "bairro_id"
    t.string "cep"
    t.string "telefone_residencial"
    t.string "celular"
    t.string "email"
    t.string "estado_civil", null: false
    t.string "sexo", null: false
    t.string "cor"
    t.decimal "renda_familiar"
    t.integer "numero_de_filhos", default: 0, null: false
    t.integer "numero_de_dependentes", default: 0, null: false
    t.bigint "user_id", null: false
    t.bigint "pessoa_id"
    t.text "observacoes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "estado_id"
    t.bigint "municipio_id"
    t.date "data_nascimento"
    t.string "nome_social"
    t.bigint "seguimento_id"
    t.bigint "profissao_id"
    t.integer "ativo", default: 1
    t.string "facebook"
    t.integer "apoiador", default: 0
    t.integer "pesquisado", default: 0
    t.integer "visitado", default: 0
    t.string "complemento"
    t.integer "equipe", default: 0
    t.bigint "funcao_id"
    t.index ["bairro_id"], name: "index_pessoas_on_bairro_id"
    t.index ["cidade_id"], name: "index_pessoas_on_cidade_id"
    t.index ["estado_id"], name: "index_pessoas_on_estado_id"
    t.index ["funcao_id"], name: "index_pessoas_on_funcao_id"
    t.index ["municipio_id"], name: "index_pessoas_on_municipio_id"
    t.index ["pessoa_id"], name: "index_pessoas_on_pessoa_id"
    t.index ["profissao_id"], name: "index_pessoas_on_profissao_id"
    t.index ["seguimento_id"], name: "index_pessoas_on_seguimento_id"
    t.index ["user_id"], name: "index_pessoas_on_user_id"
  end

  create_table "profissoes", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seguimentos", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: ""
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.integer "status", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "acoes", "pessoas"
  add_foreign_key "acoes", "users"
  add_foreign_key "bairros", "cidades"
  add_foreign_key "carros", "pessoas"
  add_foreign_key "carros", "users"
  add_foreign_key "cidades", "municipios"
  add_foreign_key "funcoes", "users"
  add_foreign_key "municipios", "estados"
  add_foreign_key "pessoas", "bairros"
  add_foreign_key "pessoas", "cidades"
  add_foreign_key "pessoas", "estados"
  add_foreign_key "pessoas", "funcoes"
  add_foreign_key "pessoas", "municipios"
  add_foreign_key "pessoas", "pessoas"
  add_foreign_key "pessoas", "profissoes"
  add_foreign_key "pessoas", "seguimentos"
  add_foreign_key "pessoas", "users"
end
