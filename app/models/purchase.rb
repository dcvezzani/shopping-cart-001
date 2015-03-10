class Purchase < ActiveRecord::Base
  has_many :purchased_products
  has_many :products, through: :purchased_products
  belongs_to :user

  # add products to the purchase
  def add_products!(products)
    processing_errors = []

    Purchase.transaction do
      products.each do |product|
        entry = PurchaseEntry.new(product)
        if(entry.valid?)
          begin
            self.add_product!(entry.product_id, entry.quantity)

          rescue Exception => e
            processing_errors = [{error: e.message}]
          end
        else
          processing_errors = entry.errors
        end

        break if(processing_errors.length > 0)
      end

      unless(processing_errors.length > 0)
        self.save!
      end
    end

    return processing_errors
  end

  # add a single product to the purchase and update the quantity
  def add_product!(product_id, quantity)
    product = Product.find product_id
    
    if(product.stock >= quantity)
      product.stock -= quantity
      if(product.save!)
        purchased_product = PurchasedProduct.new(product_id: product_id, quantity: quantity)
        self.purchased_products << purchased_product
      end
    else
      raise "There are only #{product.stock} products in stock and #{quantity} were requested"
    end
  end

  # show json of records involved in purchase
  def prepare_response
      json = JSON.parse(self.to_json)
      Product.joins{purchased_products}.where{(purchased_products.purchase_id == my{self.id})}.select{[id, name, stock, purchased_products.quantity]}
      json["products"] = JSON.parse(self.products.to_json)
      json
  end
end
