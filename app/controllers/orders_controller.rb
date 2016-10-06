class OrdersController < ApplicationController

  def new
    @client_token = Braintree::ClientToken.generate
  end

  def create
     nonce = params["payment_method_nonce"]
  end

def checkout

   nonce = params["payment_method_nonce"]

  result = Braintree::Transaction.sale(
   
    amount: "1.00",
    # use line below for implementation
    # :payment_method_nonce => params[:payment_method_nonce]
    # payment_method_nonce: 'nonce',
    
    # use lines below for testing
      payment_method_nonce: 'fake-valid-nonce',
    # payment_method_nonce: 'fake-luhn-invalid-nonce'

     :customer =>  {
        :first_name =>  "Jane",
        :last_name => "Doe",
        :phone => "415-221-3252",
        :email => "janed@example.com"
     },

     :billing => {
        :first_name => "Jane",
        :last_name => "Doe",
        :street_address => "1123 Market Street",
        :extended_address => "Apt. 201",
        :locality => "San Francisco",
        :region => "CA",
        :postal_code => "94614"    
      },

     :options => {
        :submit_for_settlement => true,
        :store_in_vault_on_success => true
     },
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
