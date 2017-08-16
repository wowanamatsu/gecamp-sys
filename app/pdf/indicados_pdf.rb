# encoding: utf-8

class IndicadosPDF < Prawn::Document

	def initialize(params)
		super( :top_margin => 20,  :page_size => "A4" )

		@dados = Pessoa.select(:nome, :nome_social, :pessoa_id, :endereco, :complemento)
		.where(:pessoa_id => params[:args])
		@indicado_por = Pessoa.select(:nome).where(:id => params[:args])
		@user = params[:user]

		header
		content
		footer
	end


	def content

		move_down(50)

		@dados.each do |p|
			data = [[
				"Nome\nNome Social\nEndereço\nBairro",
				"#{p.nome}
				#{p.nome_social}
				#{p.endereco} número #{p.complemento}
				bairro"
				]]

				estilo = {
					:borders => [:bottom, :top],
					:font => "Helvetica", 
					:size => 9
				}

				table(data,  cell_style: estilo ) do
					columns(0).width = 100
					columns(1).width = 423

				end
		end
	end


	def header
		

		data = [[
			"Gecamp-sys
			Relatório de pessoas indicadas por: #{@indicado_por[0].nome}
			Data: #{I18n.l Time.now, :format => '%d de %B de %Y'}
			"
			]]

			estilo = {
				:width => 520,
				:border_width => 0,
				:font => "Helvetica",
				:size => 10
			}

		table(data, cell_style: estilo)
	end

	def footer
		page_count.times do |i|
			go_to_page(i+1)

			draw_text "GECAMP-SYS   -   Brasilia, #{I18n.l Time.now, :format => '%d de %B de %Y'}", :at => [10, -10], :font => "Arial", :size => 10
		end
	end
end