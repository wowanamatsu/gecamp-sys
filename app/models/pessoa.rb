class Pessoa < ApplicationRecord
  enum ativo: [:inativo, :ativo]
  enum pesquisado: [:nao_pesquisado, :sim_pesquisado]
  enum visitado: [:nao_visitado, :sim_visitado]
  enum apoiador: [:nao_apoiador, :sim_apoiador]
  enum equipe: [:nao, :sim]

  belongs_to :cidade
  belongs_to :bairro
  belongs_to :user
  belongs_to :estado
  belongs_to :municipio
  belongs_to :profissao
  belongs_to :seguimento
  belongs_to :funcao, optional: true
  has_many :pessoas
  has_many :carros
  has_many :acoes

  validates_presence_of :nome, :endereco, :cidade_id, :seguimento_id, message: 'deve ser preenchido.'
  validates_presence_of :sexo, :cor, :estado_id, :municipio_id, message: 'deve ser preenchido.'
  validates_presence_of :estado_civil, :bairro_id, :profissao_id, message: 'deve ser preenchido.'
  validates_presence_of :equipe, :pesquisado, :visitado, :apoiador, message: 'deve ser preenchido.'

  validates_format_of :email, :allow_blank => true, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: 'formato incorreto.'
  validates_uniqueness_of :email, :allow_blank => true, message: 'e-mail já cadastrado.'

  def indicado
    Pessoa.select(:nome).where(:id => self.pessoa_id)[0].try(:nome)
  end

  def self.search(query)
    where("(TRANSLATE(lower(pessoas.nome),
      'áéíóúàèìòùãõâêîôôäëïöüçÁÉÍÓÚÀÈÌÒÙÃÕÂÊÎÔÛÄËÏÖÜÇ',
      'aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC')
      like ?)", "%#{query.downcase}%")
    .where(:ativo => 'ativo')
  end

  def self.main_search(query)
    cidade = Cidade.where("(TRANSLATE(lower(cidades.nome),
      'áéíóúàèìòùãõâêîôôäëïöüçÁÉÍÓÚÀÈÌÒÙÃÕÂÊÎÔÛÄËÏÖÜÇ',
      'aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC')
      like ?)", "%#{query}%")

    busca_cidade = nil
    if not cidade.empty?
      busca_cidade = cidade[0].id
    else
      busca_cidade = 9999
    end

    where("(TRANSLATE(lower(pessoas.nome),
      'áéíóúàèìòùãõâêîôôäëïöüçÁÉÍÓÚÀÈÌÒÙÃÕÂÊÎÔÛÄËÏÖÜÇ',
      'aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC')
      like ?)

      OR pessoas.telefone_residencial LIKE ?

      OR (TRANSLATE(lower(pessoas.endereco),
      'áéíóúàèìòùãõâêîôôäëïöüçÁÉÍÓÚÀÈÌÒÙÃÕÂÊÎÔÛÄËÏÖÜÇ',
      'aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC') LIKE ?)

      OR pessoas.celular LIKE ? OR pessoas.cidade_id = ?",


      "%#{query.downcase}%", "%#{query}%", "%#{query}%", "%#{query}%", busca_cidade)
    .where(:ativo => 'ativo')
  end

  def self.get_assocs()
    self.joins(:cidade).select('pessoas.id, pessoas.nome, pessoas.endereco, pessoas.cidade_id, cidades.nome as cidade_nome, pessoas.telefone_residencial, pessoas.celular, pessoas.apoiador, pessoas.pesquisado, pessoas.visitado')
    # self.joins(:cidade)
    #     .select('pessoas.id, pessoas.nome, pessoas.endereco, pessoas.cidade_id as cidade_id,
    #       pessoas.telefone_residencial, pessoas.celular, pessoas.apoiador, pessoas.pesquisado, pessoas.visitado')
  end

  def cidade_(params)
    Cidade.find(params).nome
  end

  def apoiador?
    if self.apoiador == 'sim_apoiador'
      'SIM'
    else
      'NÃO'
    end
  end

  def visitado?
    Acao.where(pessoa_id: self.id, tipo_acao: 'visita').count
  end

  def pesquisado?
    Acao.where(pessoa_id: self.id, tipo_acao: 'pesquisa').count
  end

end
