class FuncoesController < ApplicationController
  before_action :set_funcao, only: [:show, :edit, :update, :destroy]

  # GET /funcoes
  # GET /funcoes.json
  def index
    @funcoes = Funcao.all
  end

  # GET /funcoes/1
  # GET /funcoes/1.json
  def show
  end

  # GET /funcoes/new
  def new
    @funcao = Funcao.new
  end

  # GET /funcoes/1/edit
  def edit
  end

  # POST /funcoes
  # POST /funcoes.json
  def create
    @funcao = Funcao.new(funcao_params)
    @funcao.user_id = current_user.id

    respond_to do |format|
      if @funcao.save
        format.html { redirect_to @funcao, notice: 'Funcao was successfully created.' }
        format.json { render :show, status: :created, location: @funcao }
      else
        format.html { render :new }
        format.json { render json: @funcao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /funcoes/1
  # PATCH/PUT /funcoes/1.json
  def update
    respond_to do |format|
      if @funcao.update(funcao_params)
        format.html { redirect_to @funcao, notice: 'Funcao was successfully updated.' }
        format.json { render :show, status: :ok, location: @funcao }
      else
        format.html { render :edit }
        format.json { render json: @funcao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funcoes/1
  # DELETE /funcoes/1.json
  def destroy
    @funcao.destroy
    respond_to do |format|
      format.html { redirect_to funcoes_url, notice: 'Funcao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funcao
      @funcao = Funcao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def funcao_params
      params.require(:funcao).permit(:nome, :user_id)
    end
end
