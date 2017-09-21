json.extract! acao, :id, :pessoa_id, :user_id, :tipo_acao, :assunto, :agendamento, :descricao, :observacao, :status, :created_at, :updated_at
json.url acao_url(acao, format: :json)
