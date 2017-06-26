class Ability
  include CanCan::Ability
  def initialize(user)
    if user.admin?
      can :manage, :all

    elsif user.ativo?
      can [:read, :create, :update], [Pessoa, Bairro, Cidade, Estado, Municipio, Profissao, Seguimento]
      
      can [:read, :update], User 

    else
      # can [:update], User
      can [:read], Pessoa
    end
  end
end