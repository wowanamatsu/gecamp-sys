class AddFieldsLocalidadeToAcao < ActiveRecord::Migration[5.1]
  def change
    add_reference :acoes, :cidade, foreign_key: true
    add_reference :acoes, :bairro, foreign_key: true
    add_column :acoes, :endereco, :string
  end
end
