class Pessoa < ApplicationRecord
  belongs_to :cidade
  belongs_to :bairro
  belongs_to :user
  belongs_to :pessoa

  validates_presence_of :nome, :endereco, :cidade, :numero_de_filhos, message: 'deve ser preenchido.'
  validates_presence_of :user_id, :numero_de_dependentes, :sexo, :cor, message: 'deve ser preenchido.'
  validates_presence_of :estado_civil, message: 'deve ser preenchido.'
end
