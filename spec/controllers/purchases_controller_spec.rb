require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #step_two" do
    it "returns http success" do
      sign_in
      get :step_two
      expect(response).to have_http_status(:success)
    end
  end

end
