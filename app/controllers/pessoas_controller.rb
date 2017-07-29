class PessoasController < ApplicationController
  before_action :set_pessoa, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /pessoas
  # GET /pessoas.json
  def index
    if params[:select2_trigger]
      if params[:q]
        @pessoas = Pessoa.select("pessoas.id, pessoas.nome")
        .search(params[:q])
        @pessoa = @pessoas.page(params[:page] || 1).per(10)
      end

      respond_to do |format|
        format.html
        format.json {
          render :json => {
            :pessoas => @pessoa,
            :total => @pessoa.count,
            :links => { :self => @pessoa.current_page, :next => @pessoa.next_page}
          }
        }
      end

    elsif params[:search] and params[:search] != ''
      @pessoas = Pessoa.select(:id, :nome, :endereco, :cidade_id, :telefone_residencial, :celular)
      .search(params[:search])
      .order(:nome).page(params[:page] || 1).per(10)
      render action: :index, layout: request.xhr? == nil

    elsif params[:main_search] and params[:main_search] != ''
      @pessoas = Pessoa.select(:id, :nome, :endereco, :cidade_id, :telefone_residencial, :celular)
      .main_search(params[:main_search])
      .order(:nome).page(params[:page] || 1).per(10)
      render action: :index, layout: request.xhr? == nil

    else
      @pessoas = Pessoa.select(:id, :nome, :endereco, :cidade_id, :telefone_residencial, :celular)
      .where(:ativo => 'ativo')
      .order(:nome).page(params[:page] || 1).per(10)
      render action: :index, layout: request.xhr? == nil
    end
  end

  # GET /pessoas/1
  # GET /pessoas/1.json
  def show
    redirect_to pessoas_path, alert: 'Error! Essa transação não pode ser completada.' if not @pessoa.ativo?
    respond_to do |format|
      format.html
      format.pdf do
        pdf = PessoaPDF.new(user: current_user, pessoa_id: @pessoa.id)
        send_data pdf.render, :filename => "person_#{@pessoa.nome}.pdf", 
        :type => "application/pdf", 
        :disposition => "inline"
      end
    end
  end

  # GET /pessoas/new
  def new
    @pessoa = Pessoa.new
  end

  # GET /pessoas/1/edit
  def edit
    if @pessoa.ativo?
      if @pessoa.data_nascimento
        data = @pessoa.data_nascimento
        @pessoa.data_nascimento = data.to_s[8..10] + '/' + data.to_s[5..6] + '/' + data.to_s[0..3]
      end
    else
      redirect_to pessoas_url, alert: 'Error! Essa transação não pode ser completada.'
    end
  end

  # POST /pessoas
  # POST /pessoas.json
  def create
    @pessoa = Pessoa.new(pessoa_params)

    respond_to do |format|
      if @pessoa.save
        format.html { redirect_to @pessoa, notice: 'Registro adicionado com sucesso.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /pessoas/1
  # PATCH/PUT /pessoas/1.json
  def update
    respond_to do |format|
      if @pessoa.update(pessoa_params)
        format.html { redirect_to @pessoa, notice: 'Registro atualizado com sucesso.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /pessoas/1
  # DELETE /pessoas/1.json
  def destroy
    # @pessoa.destroy
    @pessoa.ativo = 'inativo'
    @pessoa.save
    respond_to do |format|
      format.html { redirect_to pessoas_url, notice: 'Registro apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pessoa
      @pessoa = Pessoa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pessoa_params
      params.require(:pessoa).permit(:nome, :endereco, :cidade_id, :bairro_id, :cep, :telefone_residencial, 
        :celular, :email, :estado_civil, :sexo, :cor, :renda_familiar, :numero_de_filhos, 
        :numero_de_dependentes, :user_id, :pessoa_id, :observacoes, :estado_id, :municipio_id, 
        :data_nascimento, :nome_social, :seguimento_id, :profissao_id, :facebook, :apoiador, :pesquisado,
        :visitado, :complemento )
    end
  end
