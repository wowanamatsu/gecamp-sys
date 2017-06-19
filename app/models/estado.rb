class Estado < ApplicationRecord
  has_many :municipios, dependent: :restrict_with_error
  has_many :pessoas, dependent: :restrict_with_error
  validates_presence_of :nome, :sigla, message: 'Deve ser preenchido.'
  validates_uniqueness_of :nome, :case_sensitive => false, message: 'Já existe um estado com esse nome cadastrado.'
end
