# frozen_string_literal: true

class GChecklistVeiculo < ApplicationRecord
  belongs_to :g_vistoria_veiculo, class_name: "GVistoriaVeiculo"
  belongs_to :g_tipo_item_checklist, class_name: "GTipoItemChecklist"
  belongs_to :g_estado_conservacao_veiculo, class_name: "GEstadoConservacaoVeiculo"
end
