namespace :batch do
  desc " Changes pending Gig payments to complete"
  task gig_payment_complete: :environment do
    @gig_payments = GigPayment.current_state("pending")
      @gig_payments.each do |payment|
        payment.completed
      end
  end

end
