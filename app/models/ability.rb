class Ability
  include CanCan::Ability
  def initialize(user)
    if user.admin?
      can :manage, :all

    elsif user.ativo? and user.normal?
      can [:read, :create], [Pessoa, Bairro, Cidade, Estado, Municipio, Profissao, Seguimento, Acao]
      
      can [:read, :update], User

      cannot [:read, :create, :update], Funcao

    else
      # can [:update], User
      can [:read], Pessoa
    end
  end
end