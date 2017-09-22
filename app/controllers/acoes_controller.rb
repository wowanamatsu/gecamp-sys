class AcoesController < ApplicationController
  before_action :set_acao, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /acoes
  # GET /acoes.json
  def index
    @acoes = Acao
            .select(:id, :pessoa_id, :tipo_acao, :agendamento, :status, :assunto)
            .order(:pessoa_id)
            .order(:agendamento)
            .page(params[:page] || 1).per(8)
            render action: :index, layout: request.xhr? == nil
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
    data = @acao.agendamento
    @acao.agendamento = data.to_s[8..10] + '/' + data.to_s[5..6] + '/' + data.to_s[0..3]
  end

  # POST /acoes
  # POST /acoes.json
  def create
    @acao = Acao.new(acao_params)
    @acao.user_id = current_user.id

    respond_to do |format|
      if @acao.save
        format.html { redirect_to @acao.pessoa, notice: 'Ação cadastrada com sucesso.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /acoes/1
  # PATCH/PUT /acoes/1.json
  def update
    respond_to do |format|
      if @acao.update(acao_params)
        format.html { redirect_to @acao.pessoa, notice: 'Ação atualizada com sucesso.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /acoes/1
  # DELETE /acoes/1.json
  def destroy
    @acao.destroy
    respond_to do |format|
      format.html { redirect_to @acao.pessoa, notice: 'Ação deletada com sucesso.' }
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
      params.require(:acao).permit(:pessoa_id, :user_id, :tipo_acao, :assunto, :agendamento, :descricao, :observacao, :status, :cidade_id, :bairro_id, :endereco)
    end
  end
