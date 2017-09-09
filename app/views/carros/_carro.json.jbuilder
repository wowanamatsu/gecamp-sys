json.extract! carro, :id, :nome, :cor, :placa, :observacoes, :pessoa_id, :user_id, :created_at, :updated_at
json.url carro_url(carro, format: :json)
