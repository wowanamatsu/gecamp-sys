class Bairro < ApplicationRecord
  belongs_to :cidade
  validates_presence_of :nome, :cidade_id, message: 'deve ser preenchido.'
end