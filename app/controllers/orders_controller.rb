class OrdersController < ApplicationController

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
        :first_name =>  "Virginia",
        :last_name => "Cooper",
        :phone => "330-389-2571",
        :email => "vcooper_us@yahoo.com"
     },

     :billing => {
        :first_name => "Virginia",
        :last_name => "Cooper",
        :street_address => "3760 Park Boulevard Way",
        :extended_address => "Apt. 34",
        :locality => "Oakland",
        :region => "CA",
        :postal_code => "94610"    
      },

     :options => {
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
