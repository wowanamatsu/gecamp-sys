module PessoasHelper
  def seguimentos
    @seguimentos = Seguimento.select(:id, :nome).order(:nome)
  end

  def profissoes
    @profissoes = Profissao.select(:id, :nome).order(:nome)
  end
end
