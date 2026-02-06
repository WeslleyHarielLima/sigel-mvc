# app/models/g_tipo_item_checklist.rb
class GTipoItemChecklist < ApplicationRecord
  belongs_to :parent, class_name: "GTipoItemChecklist", optional: true
  has_many   :children, class_name: "GTipoItemChecklist", foreign_key: :parent_id, dependent: :destroy

  has_many :g_checklists_veiculos

  scope :raizes, -> { where(parent_id: nil) }
end
