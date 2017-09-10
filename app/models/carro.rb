class Carro < ApplicationRecord
  belongs_to :pessoa
  belongs_to :user

  validates_presence_of :nome, :cor, :placa, :user_id, message: 'deve ser preenchido.'
  validates_presence_of :pessoa_id, message: 'Esse registro deve ser feito a partir de uma pessoa.'
end
