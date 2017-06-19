class User < ApplicationRecord
  enum role: [:normal, :convidado, :admin, :staff]
  enum status: [:inativo, :ativo]

  has_many :pessoas, dependent: :restrict_with_error


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable,  :registerable,
  devise :database_authenticatable,
  :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name, message: 'deve ser preenchido.'

  validate :password_complexity
  def password_complexity
    if password.present?
      if !password.match(/^(?=.*\d)(?=.*\W)(?=.*([a-z]))(?=.*([A-Z]))([\x20-\x7E]){8,40}$/) 
        errors.add :password, "Senha muito fraca!"
      end
    end
  end
end
