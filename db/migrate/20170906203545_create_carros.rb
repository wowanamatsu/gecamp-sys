class CreateCarros < ActiveRecord::Migration[5.1]
  def change
    create_table :carros do |t|
      t.string :nome
      t.string :cor
      t.string :placa
      t.text :observacoes
      t.references :pessoa, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
