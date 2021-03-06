class RelatoriosController < ApplicationController
	
	def index
		authorize! :index, ApplicationController
		if params[:pessoa]
			if params[:pessoa]['indicado_por'] and params[:pessoa]['indicado_por'] != ''
				@people = Pessoa.where("pessoa_id = ?", params[:pessoa]['indicado_por'])
				@result_indicado_por = "foram encontrados #{@people.count}, registros no sistema."
				@display_indicado_por = @people.count > 0 ? true : false
			end
		end

		respond_to do |format|
			format.html
			format.json { render :json => @people }

			format.pdf do
				if params[:pessoa]['indicado_por'] and params[:pessoa]['indicado_por'] != ''
					pdf = IndicadosPDF.new(:args => params[:pessoa]['indicado_por'], :user => current_user)
					send_data pdf.render, :filename => "relatorios_#{@people}.pdf", :type => "application/pdf", :disposition => "inline"
				end
			end
		end
	end


end
