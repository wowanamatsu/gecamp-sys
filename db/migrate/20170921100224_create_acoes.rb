class CreateAcoes < ActiveRecord::Migration[5.1]
  def change
    create_table :acoes do |t|
      t.references :pessoa, foreign_key: true
      t.references :user, foreign_key: true
      t.string :tipo_acao
      t.string :assunto
      t.date :agendamento
      t.string :descricao
      t.text :observacao
      t.string :status

      t.timestamps
    end
  end
end
