class Acao < ApplicationRecord

	enum status: [:aberto, :fechado]
	enum tipo_acao: [:pesquisa, :visita]

	belongs_to :pessoa
	belongs_to :user

	validates_presence_of :tipo_acao, :status, :assunto, :agendamento, :descricao, message: 'deve ser preenchido.'
	validates_presence_of :pessoa_id, message: 'Essa ação requer que uma pessoa seja indicada.'
end