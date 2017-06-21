class CreateProfissoes < ActiveRecord::Migration[5.1]
  def change
    create_table :profissoes do |t|
      t.string :nome

      t.timestamps
    end
  end
end
