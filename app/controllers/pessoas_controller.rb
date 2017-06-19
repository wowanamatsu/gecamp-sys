class PessoasController < ApplicationController
  before_action :set_pessoa, only: [:show, :edit, :update, :destroy]

  # GET /pessoas
  # GET /pessoas.json
  def index
    if params[:select2_trigger]
      if params[:q]
        @pessoas = Pessoa.select("pessoas.id, pessoas.nome")
        .where("(TRANSLATE(lower(pessoas.nome), 
          'áéíóúàèìòùãõâêîôôäëïöüçÁÉÍÓÚÀÈÌÒÙÃÕÂÊÎÔÛÄËÏÖÜÇ', 
          'aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC') 
          like '%#{params[:q].downcase}%' or lower(pessoas.nome) 
          like '%#{params[:q].downcase}%')")
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
    else
      @pessoas = Pessoa.select(:id, :nome, :endereco, :telefone_residencial, :celular)
      .order(:nome).page(params[:page] || 1).per(10)
      render action: :index, layout: request.xhr? == nil
    end
  end

  # GET /pessoas/1
  # GET /pessoas/1.json
  def show
  end

  # GET /pessoas/new
  def new
    @pessoa = Pessoa.new
  end

  # GET /pessoas/1/edit
  def edit
  end

  # POST /pessoas
  # POST /pessoas.json
  def create
    @pessoa = Pessoa.new(pessoa_params)
    # @pessoa.user_id = current_user.id

    respond_to do |format|
      if @pessoa.save
        format.html { redirect_to pessoas_path, notice: 'Registro adicionado com sucesso.' }
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
    @pessoa.destroy
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
      params.require(:pessoa).permit(:nome, :endereco, :cidade_id, :bairro_id, :cep, :telefone_residencial, :celular, :email, :estado_civil, :sexo, :cor, :renda_familiar, :numero_de_filhos, :numero_de_dependentes, :user_id, :pessoa_id, :observacoes, :estado_id, :municipio_id, :data_nascimento)
    end
  end
