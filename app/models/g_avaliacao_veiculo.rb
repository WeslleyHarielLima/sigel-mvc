# app/models/g_avaliacao_veiculo.rb
class GAvaliacaoVeiculo < ApplicationRecord
  belongs_to :g_veiculo
  belongs_to :avaliador, class_name: "User", foreign_key: :user_id_avaliador
end
