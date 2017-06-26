class ProfissoesController < ApplicationController
  before_action :set_profissao, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /profissoes
  # GET /profissoes.json
  def index
    @profissoes = Profissao.all
  end

  # GET /profissoes/1
  # GET /profissoes/1.json
  def show
  end

  # GET /profissoes/new
  def new
    @profissao = Profissao.new
  end

  # GET /profissoes/1/edit
  def edit
  end

  # POST /profissoes
  # POST /profissoes.json
  def create
    @profissao = Profissao.new(profissao_params)

    respond_to do |format|
      if @profissao.save
        format.html { redirect_to profissoes_path, notice: 'Registro criado com sucesso.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /profissoes/1
  # PATCH/PUT /profissoes/1.json
  def update
    respond_to do |format|
      if @profissao.update(profissao_params)
        format.html { redirect_to profissoes_path, notice: 'Registro atualizado com sucesso.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /profissoes/1
  # DELETE /profissoes/1.json
  def destroy
    if not @profissao.pessoas.empty?
      redirect_to profissoes_path, alert: "Não é possível deletar a profissao (#{@profissao.nome}). Existem pessoas ligadas a ela."
    else
      @profissao.destroy
      redirect_to profissoes_path, notice: 'Registro deletado om sucesso.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profissao
      @profissao = Profissao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profissao_params
      params.require(:profissao).permit(:nome)
    end
  end
