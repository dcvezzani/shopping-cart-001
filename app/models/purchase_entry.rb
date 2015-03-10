class PurchaseEntry
  include ActiveModel::Validations

  attr_accessor :product_id, :quantity

  validates :product_id, :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def initialize(attrs={})
    @product_id = attrs[:id].to_i
    @quantity = attrs[:quantity].to_i
  end
end
