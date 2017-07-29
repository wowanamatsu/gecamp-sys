class AddFieldComplementoToPessoa < ActiveRecord::Migration[5.1]
  def change
    add_column :pessoas, :complemento, :string
  end
end
