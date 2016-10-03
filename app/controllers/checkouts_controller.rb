class CheckoutsController < ApplicationController
  TRANSACTION_SUCCESS_STATUSES = [
    Braintree::Transaction::Status::Authorizing,
    Braintree::Transaction::Status::Authorized,
    Braintree::Transaction::Status::Settled,
    Braintree::Transaction::Status::SettlementConfirmed,
    Braintree::Transaction::Status::SettlementPending,
    Braintree::Transaction::Status::Settling,
    Braintree::Transaction::Status::SubmittedForSettlement,
  ]

  def new
    
   @client_token = Braintree::ClientToken.generate
    
  end

  def show
    @transaction = Braintree::Transaction.find(params[:id])
    @result = _create_result_hash(@transaction)
  end

  def create

    result = Braintree::Customer.create(
  :first_name => "Charity",
  :last_name => "Smith",
  :payment_method_nonce => 'fake-valid-nonce'
)
if result.success?
  puts result.customer.id
  puts result.customer.payment_methods[0].token
else
  p result.errors
end


    @result = Braintree::Transaction.sale(
      amount: params[:amount],
      payment_method_nonce: params[:payment_method_nonce])

    if @result.success? || @result.transaction
      redirect_to checkout_path(@result.transaction.id)
    else
      error_messages = @result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
      flash[:error] = error_messages
      redirect_to new_checkout_path
    end 



  end

  def _create_result_hash(transaction)
    status = transaction.status

    if TRANSACTION_SUCCESS_STATUSES.include? status
      result_hash = {
        :header => "Sweet Success!",
        :icon => "success",
        :message => "Your test transaction has been successfully processed. See the Braintree API response and try again."
      }
    else
      result_hash = {
        :header => "Transaction Failed",
        :icon => "fail",
        :message => "Your test transaction has a status of #{status}. See the Braintree API response and try again."
      }
    end
  end
end