class Seguimento < ApplicationRecord
  has_many :pessoas
  validates_presence_of :nome, message: 'deve ser preenchido.'
end
