class SeguimentosController < ApplicationController
  before_action :set_seguimento, only: [:show, :edit, :update, :destroy]

  # GET /seguimentos
  # GET /seguimentos.json
  def index
    @seguimentos = Seguimento.all
  end

  # GET /seguimentos/1
  # GET /seguimentos/1.json
  def show
  end

  # GET /seguimentos/new
  def new
    @seguimento = Seguimento.new
  end

  # GET /seguimentos/1/edit
  def edit
  end

  # POST /seguimentos
  # POST /seguimentos.json
  def create
    @seguimento = Seguimento.new(seguimento_params)

    respond_to do |format|
      if @seguimento.save
        format.html { redirect_to seguimentos_path, notice: 'Registro criando com sucesso.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /seguimentos/1
  # PATCH/PUT /seguimentos/1.json
  def update
    respond_to do |format|
      if @seguimento.update(seguimento_params)
        format.html { redirect_to seguimentos_path, notice: 'Registro atualizado com sucesso.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /seguimentos/1
  # DELETE /seguimentos/1.json
  def destroy
    if not @seguimento.pessoas.empty?
      redirect_to seguimentos_path, alert: "Não é possível deletar o seguimento (#{@seguimento.nome}). Existem pessoas ligadas a ele."
    else
      @seguimento.destroy
      redirect_to seguimentos_url, notice: 'Seguimento was successfully destroyed.' 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seguimento
      @seguimento = Seguimento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seguimento_params
      params.require(:seguimento).permit(:nome)
    end
  end
