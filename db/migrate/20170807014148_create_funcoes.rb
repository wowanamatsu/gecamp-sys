class CreateFuncoes < ActiveRecord::Migration[5.1]
  def change
    create_table :funcoes do |t|
      t.string :nome
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
