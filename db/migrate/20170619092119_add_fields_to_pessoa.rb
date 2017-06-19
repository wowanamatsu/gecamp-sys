class AddFieldsToPessoa < ActiveRecord::Migration[5.1]
  def change
    add_reference :pessoas, :estado, foreign_key: true
    add_reference :pessoas, :municipio, foreign_key: true
    add_column :pessoas, :data_nascimento, :date, null: true
  end
end
