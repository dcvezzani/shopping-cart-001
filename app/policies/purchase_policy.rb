class PurchasePolicy

  attr_reader :current_user, :purchase

  def initialize(current_user, purchase)
    @current_user = current_user
    @purchase = purchase
  end

  def update?
    current_user.approved?
    #or (purchase.user == current_user)
  end
end
