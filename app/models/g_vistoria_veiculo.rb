class GVistoriaVeiculo < ApplicationRecord
  belongs_to :g_veiculo
  belongs_to :responsavel, class_name: "User", foreign_key: :user_id_responsavel
end
