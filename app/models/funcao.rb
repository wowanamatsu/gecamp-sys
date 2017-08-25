class Funcao < ApplicationRecord
  belongs_to :user
  has_many :pessoas

  validates_presence_of :user_id, :nome, message: 'deve ser preenchido'
end
