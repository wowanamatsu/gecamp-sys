class UsersController < ApplicationController
 before_action :set_user, only: [:show, :edit, :update, :destroy]
 load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    if current_user.admin?
      @users = User.all
    else
      @users = User.where(:id => current_user.id)
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'Usuário criado com sucesso.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.id == current_user.id || current_user.admin?
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
          params[:user].delete(:password)
          params[:user].delete(:password_confirmation)
      end
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to users_path, notice: 'Usuário atualizado com sucesso.' }
        else
          format.html { render :edit }
        end
      end
    else
      redirect_to users_path, alert: "Vovê não tem autorização para atualizar o usuário: (#{@user.name})"
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Usuário removido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :role, :status)
    end
  end
