class AddProfissaoSeguimentoToPessoa < ActiveRecord::Migration[5.1]
  def change
    add_column :pessoas, :nome_social, :string, null:true
    add_reference :pessoas, :seguimento, foreign_key: true, null: true
    add_reference :pessoas, :profissao, foreign_key: true, null: true
  end
end
