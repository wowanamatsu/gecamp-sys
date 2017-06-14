class CidadesController < ApplicationController
  before_action :set_cidade, only: [:show, :edit, :update, :destroy]

  # GET /cidades
  # GET /cidades.json
  def index
    @cidades = Cidade.all
  end

  # GET /cidades/1
  # GET /cidades/1.json
  def show
  end

  # GET /cidades/new
  def new
    @cidade = Cidade.new
  end

  # GET /cidades/1/edit
  def edit
  end

  # POST /cidades
  # POST /cidades.json
  def create
    @cidade = Cidade.new(cidade_params)

    respond_to do |format|
      if @cidade.save
        format.html { redirect_to cidades_path, notice: "#{@cidade.nome} criada com sucesso." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /cidades/1
  # PATCH/PUT /cidades/1.json
  def update
    respond_to do |format|
      if @cidade.update(cidade_params)
        format.html { redirect_to cidades_path, notice: "#{@cidade.nome} atualizada com sucesso." }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /cidades/1
  # DELETE /cidades/1.json
  def destroy
    if not @cidade.bairros.empty?
      redirect_to cidades_url, notice: "Não é possível deletar a cidade #{@cidade.nome}, existem bairros vinculados."
    else
      @cidade.destroy
      redirect_to cidades_url, notice: "#{@cidade.nome} deletada com sucesso."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cidade
      @cidade = Cidade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cidade_params
      params.require(:cidade).permit(:nome, :municipio_id)
    end
end
