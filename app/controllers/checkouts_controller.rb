class CheckoutsController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
  end

  def create
    nonce = params[:payment_method_nonce]
    render action: :new and return unless nonce
    result = Braintree::Transaction.sale(
      amount: "25.00",
      payment_method_nonce: nonce,
      options: {
        :submit_for_settlement => true
      }
    )

    flash[:notice] = "Success! You have been upgraded to premium membership." if result.success?
    
    flash[:alert] = "Sorry but there has been an error. Please try again #{result.transaction.processor_response_text}" unless result.success?
    redirect_to action: :new
  end

  def downgrade
      current_user.wikis.each {|w| w.update_attribute(:private, false) }
      current_user.update_attribute(:role, 'standard')
      flash[:notice] = "Congratulations, #{current_user.email}! You have downgraded to Standard membership."
      redirect_to wikis_path
  end

end


