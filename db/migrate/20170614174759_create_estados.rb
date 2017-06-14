class CreateEstados < ActiveRecord::Migration[5.1]
  def change
    create_table :estados do |t|
      t.string :nome
      t.string :sigla

      t.timestamps
    end
  end
end
