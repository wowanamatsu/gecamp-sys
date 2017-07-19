class HomeController < ApplicationController
  def index
    @pessoas = Pessoa
               .select(:nome, :data_nascimento, :celular)
               .where("EXTRACT(DAY FROM data_nascimento) = #{Time.now.strftime('%d').to_i}")
               .where("EXTRACT(MONTH FROM data_nascimento) = #{Time.now.strftime('%m').to_i}")
    @aniv_mes = Pessoa.select(:id)
                .where("EXTRACT(MONTH FROM data_nascimento) = #{Time.now.strftime('%m').to_i}")
    @total = @aniv_mes.count
  end
end
