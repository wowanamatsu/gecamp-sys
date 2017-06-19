class Cidade < ApplicationRecord
  belongs_to :municipio
  has_many :pessoas
  has_many :bairros, dependent: :restrict_with_error
  validates_presence_of :nome, :municipio_id, message: ' deve ser preenchido'
end
