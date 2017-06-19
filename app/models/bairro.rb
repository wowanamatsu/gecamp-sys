class Bairro < ApplicationRecord
  belongs_to :cidade
  has_many :pessoas
  validates_presence_of :nome, :cidade_id, message: 'deve ser preenchido.'
end
