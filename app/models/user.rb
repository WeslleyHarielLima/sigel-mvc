# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  ROLES = %w[user admin].freeze

  validates :nome, presence: true
  validates :cpf, presence: true, uniqueness: true, format: { with: /\A\d{11}\z/, message: "deve conter 11 dígitos numéricos" }
  validates :role, inclusion: { in: ROLES }

  def admin?
    role == "admin"
  end

  def user?
    role == "user"
  end

  def to_s
    nome
  end
end
