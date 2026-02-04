# frozen_string_literal: true

class GEstado < ApplicationRecord
  belongs_to :g_pais
  has_many   :g_municipios
end
