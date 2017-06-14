class Municipio < ApplicationRecord
  belongs_to :estado
  has_many :cidades, dependent: :restrict_with_error
  validates_presence_of :nome, :estado_id, message: ' deve ser preenchido'
end
