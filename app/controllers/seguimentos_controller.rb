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
        format.html { redirect_to @seguimento, notice: 'Seguimento was successfully created.' }
        format.json { render :show, status: :created, location: @seguimento }
      else
        format.html { render :new }
        format.json { render json: @seguimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seguimentos/1
  # PATCH/PUT /seguimentos/1.json
  def update
    respond_to do |format|
      if @seguimento.update(seguimento_params)
        format.html { redirect_to @seguimento, notice: 'Seguimento was successfully updated.' }
        format.json { render :show, status: :ok, location: @seguimento }
      else
        format.html { render :edit }
        format.json { render json: @seguimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seguimentos/1
  # DELETE /seguimentos/1.json
  def destroy
    @seguimento.destroy
    respond_to do |format|
      format.html { redirect_to seguimentos_url, notice: 'Seguimento was successfully destroyed.' }
      format.json { head :no_content }
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
