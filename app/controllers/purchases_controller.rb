class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:step_two, :create]

  # override ApplicationController exception handling since we only want json returned for
  # #purchase and #create
  rescue_from Exception do
    render json: JSON.generate({message: "Server error"}), status: 500
  end  

  rescue_from Errors::NotAuthorizedError do
    render json: JSON.generate({message: "Access Denied"}), status: :unauthorized
  end  
  
  
  def index
  end

  def step_two
    @products = Product.all
  end

  def purchase
    # give a little time to show the update to the button in the view
    sleep(1)

    if(params.has_key? "error")
      render json: JSON.generate({message: "there's been an error"}), status: 400
    else
      render json: JSON.generate({message: "Thanks for your purchase"})
    end
  end

  def create
    processing_errors = []
    @purchase = Purchase.new()
    @purchase.user = current_user

    authorize(@purchase)
    processing_errors = @purchase.add_products!(products_params)

    respond_to do |format|
      if (processing_errors.length == 0)
        format.json { render json: @purchase.prepare_response, status: :created }
      else
        format.json { render json: processing_errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def products_params
      params.require(:products) do |product|
        product.permit(:id, :quantity)
      end
    end
end
