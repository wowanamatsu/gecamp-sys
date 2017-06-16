class EstadosController < ApplicationController
  before_action :set_estado, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /estados
  # GET /estados.json
  def index
    @estados = Estado.select(:id, :nome, :sigla)
    .order(nome: :desc).page(params[:page] || 1).per(8)
    render action: :index, layout: request.xhr? == nil
  end

  # GET /estados/1
  # GET /estados/1.json
  def show
  end

  # GET /estados/new
  def new
    @estado = Estado.new
  end

  # GET /estados/1/edit
  def edit
  end

  # POST /estados
  # POST /estados.json
  def create
    @estado = Estado.new(estado_params)

    respond_to do |format|
      if @estado.save
        format.html { redirect_to estados_path, notice: "O registro #{@estado.nome}, foi salvo com sucesso." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /estados/1
  # PATCH/PUT /estados/1.json
  def update
    respond_to do |format|
      if @estado.update(estado_params)
        format.html { redirect_to estados_path, notice: "O registro #{@estado.nome}, foi atualizado com sucesso." }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /estados/1
  # DELETE /estados/1.json
  def destroy
   if not @estado.municipios.empty?
    redirect_to estados_url, notice: "Não é possível deletar o estado #{@estado.nome}, existem municípios vinculadas."
  else
    @estado.destroy
    redirect_to estados_url, notice: 'Estado was successfully destroyed.'
  end
end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_estado
      @estado = Estado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def estado_params
      params.require(:estado).permit(:nome, :sigla)
    end
  end
