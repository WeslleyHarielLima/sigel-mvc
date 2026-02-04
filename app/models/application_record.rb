class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Libera atributos básicos + permite que models incluam mais via super
  def self.ransackable_attributes(auth_object = nil)
    super + column_names
  end

  # Libera TODAS as associações
  def self.ransackable_associations(auth_object = nil)
    reflect_on_all_associations.map(&:name).map(&:to_s)
  end
end
