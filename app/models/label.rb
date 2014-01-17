require 'active_model'
class Label
  include ActiveModel::Model

  attr_accessor :name, :description, :type, :enabled, :color
  validates_presence_of :name, :description, :color

  def attributes
    {
      'name' => name,
      'description' => description,
      'enabled' => enabled,
      'color' => color
    }
  end
end
