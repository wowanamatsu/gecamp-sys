class CreatePessoas < ActiveRecord::Migration[5.1]
  def change
    create_table :pessoas do |t|
      t.string :nome,       null: false
      t.string :endereco,   null: false
      t.references :cidade, foreign_key: true
      t.references :bairro, foreign_key: true, null: true
      t.string :cep
      t.string :telefone_residencial, null: true
      t.string :celular, null: true
      t.string :email
      t.string :estado_civil, null: false
      t.string :sexo, null: false
      t.string :cor
      t.decimal :renda_familiar
      t.integer :numero_de_filhos, null: false, default: 0
      t.integer :numero_de_dependentes, null: false, default: 0
      t.references :user, foreign_key: true, null: false
      t.references :pessoa, foreign_key: true, null: true
      t.text :observacoes

      t.timestamps
    end
  end
end
