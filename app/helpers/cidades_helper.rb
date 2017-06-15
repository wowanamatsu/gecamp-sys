module CidadesHelper
  def municipios
    @municipios = Municipio.select(:id, :nome).order(:nome)
  end
end