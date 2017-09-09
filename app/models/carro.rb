class Carro < ApplicationRecord
  belongs_to :pessoa
  belongs_to :user
end
