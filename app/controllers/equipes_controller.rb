class EquipesController < ApplicationController

	def index
		authorize! :index, ApplicationController
		@equipes = Pessoa.select(:id, :nome, :funcao_id)
		.where(:ativo => 'ativo', :equipe => 'sim')
		.where.not(:funcao_id => nil)
		.order(:nome).page(params[:page] || 1).per(10)
		render action: :index, layout: request.xhr? == nil
		
	end

end