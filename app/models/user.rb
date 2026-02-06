# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  belongs_to :a_cargo, optional: true
  belongs_to :a_unidade, optional: true
  belongs_to :a_tipo_usuario
  belongs_to :a_status

  before_validation :normalize_cpf

  validates :nome,  presence: true
  validates :email, presence: true, uniqueness: true
  validates :cpf,   presence: true, uniqueness: true

  def admin?
    a_tipo_usuario&.descricao&.downcase == "admin"
  end

  def gerenciador?
    a_tipo_usuario&.descricao&.downcase == "gerenciador"
  end

  def vistoriador?
    a_tipo_usuario&.descricao&.downcase == "vistoriador"
  end

  private

  def normalize_cpf
    self.cpf = cpf.gsub(/\D/, "") if cpf.present?
  end
end
