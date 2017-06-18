json.extract! pessoa, :id, :nome, :endereco, :cidade_id, :bairro_id, :cep, :telefone_residencial, :celular, :email, :estado_civil, :sexo, :cor, :renda_familiar, :numero_de_filhos, :numero_de_dependentes, :user_id, :pessoa_id, :observacoes, :created_at, :updated_at
json.url pessoa_url(pessoa, format: :json)
