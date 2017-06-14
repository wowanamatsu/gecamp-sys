class Estado < ApplicationRecord
  has_many :municipios, dependent: :restrict_with_error
  validates_presence_of :nome, :sigla, message: 'Deve ser preenchido.'
end
