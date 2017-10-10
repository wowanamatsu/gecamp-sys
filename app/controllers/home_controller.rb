class HomeController < ApplicationController
  def index
    if !current_user.ativo?
      sign_out current_user
      redirect_to root_path
    end
    @pessoas = Pessoa
               .select(:id, :nome, :data_nascimento, :celular)
               .where("EXTRACT(DAY FROM data_nascimento) = #{Time.now.strftime('%d').to_i}")
               .where("EXTRACT(MONTH FROM data_nascimento) = #{Time.now.strftime('%m').to_i}")
               .where(:ativo => 'ativo')
    @aniv_mes = Pessoa.select(:id)
                .where("EXTRACT(MONTH FROM data_nascimento) = #{Time.now.strftime('%m').to_i}")
                .where(:ativo => 'ativo')
    @total = @aniv_mes.count
  end
end
