class CarrosController < ApplicationController
  before_action :set_carro, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /carros
  # GET /carros.json
  def index
    if params[:select2_trigger]
      if params[:q]
        @carros = Carro.select(:id, :nome, :pessoa_id, :placa, :cor)
        .where("(TRANSLATE(lower(carros.nome), 
          'áéíóúàèìòùãõâêîôôäëïöüçÁÉÍÓÚÀÈÌÒÙÃÕÂÊÎÔÛÄËÏÖÜÇ', 
          'aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC') 
          like '%#{params[:q].downcase}%' or lower(carros.nome) 
          like '%#{params[:q].downcase}%')")

        @carro = @carros.page(params[:page] || 1).per(10)
      end

      respond_to do |format|
        format.html
        format.json {
          render :json => {
            :carros => @carro,
            :total => @carro.count,
            :links => { :self => @carro.current_page, :next => @carro.next_page}
          }
        }
      end

    else
      @carros = Carro.select(:id, :nome, :pessoa_id, :cor, :placa, :observacoes,)
      .order(nome: :desc).page(params[:page] || 1).per(8)
      render action: :index, layout: request.xhr? == nil
    end
  end

  # GET /carros/1
  # GET /carros/1.json
  def show
  end

  # GET /carros/new
  def new
    @carro = Carro.new
  end

  # GET /carros/1/edit
  def edit
  end

  # POST /carros
  # POST /carros.json
  def create
    @carro = Carro.new(carro_params)
    @carro.user_id = current_user.id

    respond_to do |format|
      if @carro.save
        format.html { redirect_to @carro, notice: 'Carro criado com sucesso.' }
        format.json { render :show, status: :created, location: @carro }
      else
        format.html { render :new }
        format.json { render json: @carro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carros/1
  # PATCH/PUT /carros/1.json
  def update
    respond_to do |format|
      if @carro.update(carro_params)
        format.html { redirect_to @carro, notice: 'Carro atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @carro }
      else
        format.html { render :edit }
        format.json { render json: @carro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carros/1
  # DELETE /carros/1.json
  def destroy
    @carro.destroy
    respond_to do |format|
      format.html { redirect_to carros_url, notice: 'Carro deletado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carro
      @carro = Carro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carro_params
      params.require(:carro).permit(:nome, :cor, :placa, :observacoes, :pessoa_id, :user_id)
    end
end
