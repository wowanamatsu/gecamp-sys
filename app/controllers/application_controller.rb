class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/', :alert => 'Você não tem autorização para realizar essa ação.'
  end
end
