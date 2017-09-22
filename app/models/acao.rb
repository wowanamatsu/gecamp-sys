class Acao < ApplicationRecord

	belongs_to :pessoa
	belongs_to :user
	belongs_to :cidade
	belongs_to :bairro

	validates_presence_of :tipo_acao, :cidade_id, :bairro_id, :endereco, :status, :assunto, :agendamento, :descricao, message: 'deve ser preenchido.'
	validates_presence_of :pessoa_id, message: 'Essa ação requer que uma pessoa seja indicada.'
end