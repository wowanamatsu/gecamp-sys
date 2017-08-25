class AddEquipeFieldToPessoa < ActiveRecord::Migration[5.1]
  def change
    add_column :pessoas, :equipe, :integer, default: 0
    add_reference :pessoas, :funcao, foreign_key: true, null: true
  end
end
