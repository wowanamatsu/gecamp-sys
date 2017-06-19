class Bairro < ApplicationRecord
  belongs_to :cidade
  has_many :pessoas, dependent: :restrict_with_error
  validates_presence_of :nome, :cidade_id, message: 'deve ser preenchido.'
end
