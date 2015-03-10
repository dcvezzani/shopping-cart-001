class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:step_two, :create]

  def index
  end

  def step_two
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
    authorize(@post)
  end
end
