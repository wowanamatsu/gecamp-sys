class MunicipiosController < ApplicationController
  before_action :set_municipio, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    if params[:select2_trigger]
      if params[:q]
        estado = "and municipios.estado_id = '#{params[:estado]}'" if params[:estado] != ''
        @municipios = Municipio.select("municipios.id, municipios.nome")
        .where("(TRANSLATE(lower(municipios.nome), 
          'áéíóúàèìòùãõâêîôôäëïöüçÁÉÍÓÚÀÈÌÒÙÃÕÂÊÎÔÛÄËÏÖÜÇ', 
          'aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC') 
          like '%#{params[:q].downcase}%' or lower(municipios.nome) 
          like '%#{params[:q].downcase}%') #{estado}")
        @municipio = @municipios.page(params[:page] || 1).per(10)
      end

      respond_to do |format|  
       format.html
       format.json { 
         render :json => {
           :municipios => @municipio,
           :total => @municipio.count,
           :links => { :self => @municipio.current_page , :next => @municipio.next_page}
         } 
       }
     end

   else
    @municipios = Municipio.select(:id, :nome, :estado_id).includes(:estado)
    .order(estado_id: :desc).page(params[:page] || 1).per(10)
    render action: :index, layout: request.xhr? == nil
  end
end

  # GET /municipios/1
  # GET /municipios/1.json
  def show
  end

  # GET /municipios/new
  def new
    @municipio = Municipio.new
  end

  # GET /municipios/1/edit
  def edit
  end

  # POST /municipios
  # POST /municipios.json
  def create
    @municipio = Municipio.new(municipio_params)

    respond_to do |format|
      if @municipio.save
        format.html { redirect_to municipios_path, notice: "#{@municipio.nome}, cadastrado com sucesso." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /municipios/1
  # PATCH/PUT /municipios/1.json
  def update
    respond_to do |format|
      if @municipio.update(municipio_params)
        format.html { redirect_to municipios_path, notice: "#{@municipio.nome}, atualizado com sucesso." }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /municipios/1
  # DELETE /municipios/1.json
  def destroy
    if not @municipio.cidades.empty?
      redirect_to municipios_url, notice: "Não é possível deletar o município #{@municipio.nome}, existem cidades vinculadas."
    else
      @municipio.destroy
      redirect_to municipios_url, notice: "#{@municipio.nome} foi deletado com sucesso."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_municipio
      @municipio = Municipio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def municipio_params
      params.require(:municipio).permit(:nome, :estado_id)
    end
  end
