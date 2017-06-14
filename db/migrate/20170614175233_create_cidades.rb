class CreateCidades < ActiveRecord::Migration[5.1]
  def change
    create_table :cidades do |t|
      t.string :nome
      t.references :municipio, foreign_key: true

      t.timestamps
    end
  end
end
