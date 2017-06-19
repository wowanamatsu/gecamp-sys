class Cidade < ApplicationRecord
  belongs_to :municipio
  has_many :pessoas, dependent: :restrict_with_error
  has_many :bairros, dependent: :restrict_with_error
  validates_presence_of :nome, :municipio_id, message: ' deve ser preenchido'
end
