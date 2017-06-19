class Pessoa < ApplicationRecord
  belongs_to :cidade
  belongs_to :bairro
  belongs_to :user
  has_many :pessoas

  validates_presence_of :nome, :endereco, :cidade, message: 'deve ser preenchido.'
  validates_presence_of :sexo, :cor, message: 'deve ser preenchido.'
  validates_presence_of :estado_civil, message: 'deve ser preenchido.'

  def indicado
    Pessoa.select(:nome).where(:id => self.pessoa_id)[0].try(:nome)
  end
end
