class Pessoa < ApplicationRecord
  belongs_to :cidade
  belongs_to :bairro
  belongs_to :user
  belongs_to :estado
  belongs_to :municipio
  belongs_to :profissao
  belongs_to :seguimento
  has_many :pessoas

  validates_presence_of :nome, :endereco, :cidade_id, :seguimento_id, message: 'deve ser preenchido.'
  validates_presence_of :sexo, :cor, :estado_id, :municipio_id, message: 'deve ser preenchido.'
  validates_presence_of :estado_civil, :bairro_id, :profissao_id, message: 'deve ser preenchido.'

  def indicado
    Pessoa.select(:nome).where(:id => self.pessoa_id)[0].try(:nome)
  end
end
