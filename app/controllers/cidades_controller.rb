class CidadesController < ApplicationController
  before_action :set_cidade, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  # GET /cidades
  # GET /cidades.json
  def index
    if params[:select2_trigger]
      if params[:q]
        municipio = nil
        if params[:municipio].to_i > 0
          municipio = "and cidades.municipio_id = '#{params[:municipio]}'"
        end
        @cidades = Cidade.select("cidades.id, cidades.nome")
        .where("(TRANSLATE(lower(cidades.nome), 
          'áéíóúàèìòùãõâêîôôäëïöüçÁÉÍÓÚÀÈÌÒÙÃÕÂÊÎÔÛÄËÏÖÜÇ', 
          'aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC') 
          like '%#{params[:q].downcase}%' or lower(cidades.nome) 
          like '%#{params[:q].downcase}%') #{municipio}")

        @cidade = @cidades.page(params[:page] || 1).per(10)
      end

      respond_to do |format|
        format.html
        format.json {
          render :json => {
            :cidades => @cidade,
            :total => @cidade.count,
            :links => { :self => @cidade.current_page, :next => @cidade.next_page}
          }
        }
      end

    else
      @cidades = Cidade.select(:id, :nome, :municipio_id).order(:nome).page(params[:page] || 1).per(8)
      render action: :index, layout: request.xhr? == nil
    end
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
