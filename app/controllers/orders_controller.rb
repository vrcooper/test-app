class OrdersController < ApplicationController

def checkout
  result = Braintree::Transaction.sale(
   
    amount: "25.00",
    # use line below for implementation
    #:payment_method_nonce => params[:payment_method_nonce]

    # use lines below for testing
    payment_method_nonce: 'fake-valid-nonce'
    #payment_method_nonce: 'fake-luhn-invalid-nonce'
    )
    if result.success?
      flash[:notice] = "Payment was successful!"
    else
      flash[:error] = result.message
      redirect_to root_path
    end
  end

def downgrade
      current_user.wikis.each {|w| w.update_attribute(:private, false) }
      current_user.update_attribute(:role, 'standard')
      flash[:notice] = "Congratulations, #{current_user.email}! You have downgraded to Standard membership."
      redirect_to wikis_path
end

end
