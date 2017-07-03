# encoding: utf-8

class PessoaPDF < Prawn::Document
  def initialize(params)
    super( :top_margin => 20, :page_layout => :portrait, :page_size => "A4" ) 
    
    @pessoa = Pessoa.select(
              :nome, 
              :nome_social, 
              :endereco,
              :bairro_id,
              :cidade_id, 
              :seguimento_id,
              :apoiador,
              :telefone_residencial,
              :celular,
              :visitado,
              :observacoes,
              :pessoa_id
    ).includes(:bairro, :cidade, :seguimento).find(params[:pessoa_id])
    @user = params[:user]

    title
    content
    footer                
  end

  def indicado?
    Pessoa.select(:nome).where(:id => @pessoa.pessoa_id)[0].nome if @pessoa.pessoa_id
  end

  def content
    move_down(75)
    text_box ("
      Nome: <b>#{@pessoa.nome}</b><br>
      Nome Social: #{@pessoa.nome_social}
      Indicado por: #{indicado?}
      Endereço: #{@pessoa.endereco}
      Bairro: #{@pessoa.bairro.try(:nome)}
      Cidade: #{@pessoa.cidade.try(:nome)}
      Segmento: #{@pessoa.seguimento.try(:nome)}
      Apoiador: #{@pessoa.apoiador.sub('_',' ')}
      Telefone(s): #{@pessoa.telefone_residencial}    #{@pessoa.celular}
      Visitado: #{@pessoa.visitado.sub('_',' ')}
    "), :at => [10, 650], :inline_format => true, :font => "Arial", :size => 11

    text_box ("Observação:

      #{@pessoa.observacoes}
    "), :at => [10, 490], :inline_format => true, :font => "Arial", :size => 11
  end

  def title
    text_box "Gecamp-sys - Cadastro de Pessoas", :align => :center, :size => 18, :style => :bold, :at => [0, 730]
    text_box "Relatório de pessoas", :align => :center, :inline_format => true, :size => 12, :at => [0, 700]
  end

  def footer
    page_count.times do |i|
      go_to_page(i+1)

      draw_text "GECAMP   -   Brasília, #{I18n.l Time.now, :format => '%d de %B de %Y'}" +
      "    -    Gerado por: #{@user.name}", :at => [120, -10], :font => "Arial", :size => 10
    end
  end
end 
