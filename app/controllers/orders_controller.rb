class OrdersController < ApplicationController

def checkout
  result = Braintree::Transaction.sale(
    :amount => "25.00",
    :payment_method_nonce => params[:payment_method_nonce]
    )
    if result.success?
      flash[:notice] = "Payment was successful"
    else
      flash[:error] = result.message
      redirect_to root_path
    end
  end
end
