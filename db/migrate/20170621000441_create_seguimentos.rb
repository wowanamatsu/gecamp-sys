class CreateSeguimentos < ActiveRecord::Migration[5.1]
  def change
    create_table :seguimentos do |t|
      t.string :nome

      t.timestamps
    end
  end
end
