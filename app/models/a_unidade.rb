class AUnidade < ApplicationRecord
  belongs_to :a_orgao
  belongs_to :a_status
  belongs_to :g_municipio
end
