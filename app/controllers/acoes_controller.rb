class AcoesController < ApplicationController
  before_action :set_acao, only: [:show, :edit, :update, :destroy]

  # GET /acoes
  # GET /acoes.json
  def index
    @acoes = Acao.all
  end

  # GET /acoes/1
  # GET /acoes/1.json
  def show
  end

  # GET /acoes/new
  def new
    @acao = Acao.new
  end

  # GET /acoes/1/edit
  def edit
  end

  # POST /acoes
  # POST /acoes.json
  def create
    @acao = Acao.new(acao_params)

    respond_to do |format|
      if @acao.save
        format.html { redirect_to @acao, notice: 'Acao was successfully created.' }
        format.json { render :show, status: :created, location: @acao }
      else
        format.html { render :new }
        format.json { render json: @acao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acoes/1
  # PATCH/PUT /acoes/1.json
  def update
    respond_to do |format|
      if @acao.update(acao_params)
        format.html { redirect_to @acao, notice: 'Acao was successfully updated.' }
        format.json { render :show, status: :ok, location: @acao }
      else
        format.html { render :edit }
        format.json { render json: @acao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acoes/1
  # DELETE /acoes/1.json
  def destroy
    @acao.destroy
    respond_to do |format|
      format.html { redirect_to acoes_url, notice: 'Acao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acao
      @acao = Acao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acao_params
      params.require(:acao).permit(:pessoa_id, :user_id, :tipo_acao, :assunto, :agendamento, :descricao, :observacao, :status)
    end
end
