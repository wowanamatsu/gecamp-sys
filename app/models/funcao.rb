class Funcao < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id, :nome, message: 'deve ser preenchido'
end
