class AddFieldsFacebookApoiadorPesquisadoVisitadoToPessoa < ActiveRecord::Migration[5.1]
  def change
    add_column :pessoas, :facebook, :string
    add_column :pessoas, :apoiador, :integer, default: 0
    add_column :pessoas, :pesquisado, :integer, default: 0
    add_column :pessoas, :visitado, :integer, default: 0
  end
end
