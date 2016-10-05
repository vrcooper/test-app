class CheckoutsController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
  end

  def create
    nonce = params["payment_method_nonce"]
  end
end


