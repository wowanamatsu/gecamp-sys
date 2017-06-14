class CreateMunicipios < ActiveRecord::Migration[5.1]
  def change
    create_table :municipios do |t|
      t.string :nome
      t.references :estado, foreign_key: true

      t.timestamps
    end
  end
end
