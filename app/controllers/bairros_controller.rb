class BairrosController < ApplicationController
  before_action :set_bairro, only: [:show, :edit, :update, :destroy]

  # GET /bairros
  # GET /bairros.json
  def index
    @bairros = Bairro.all
  end

  # GET /bairros/1
  # GET /bairros/1.json
  def show
  end

  # GET /bairros/new
  def new
    @bairro = Bairro.new
  end

  # GET /bairros/1/edit
  def edit
  end

  # POST /bairros
  # POST /bairros.json
  def create
    @bairro = Bairro.new(bairro_params)

    respond_to do |format|
      if @bairro.save
        format.html { redirect_to bairros_path, notice: "Novo bairro adicionado com sucesso." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /bairros/1
  # PATCH/PUT /bairros/1.json
  def update
    respond_to do |format|
      if @bairro.update(bairro_params)
        format.html { redirect_to bairros_path, notice: "Bairro atualizado com sucesso." }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /bairros/1
  # DELETE /bairros/1.json
  def destroy
    @bairro.destroy
    respond_to do |format|
      format.html { redirect_to bairros_url, notice: "Bairro deletado com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bairro
      @bairro = Bairro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bairro_params
      params.require(:bairro).permit(:nome, :cidade_id)
    end
end
