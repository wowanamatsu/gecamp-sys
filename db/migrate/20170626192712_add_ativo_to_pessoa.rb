class AddAtivoToPessoa < ActiveRecord::Migration[5.1]
  def change
    add_column :pessoas, :ativo, :integer, default: 1
  end
end
