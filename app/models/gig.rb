class Gig < ApplicationRecord
    belongs_to :creator
    has_one :gig_payment
    enum state: { applied: 0, accepted: 1 , completed: 2, paid: 3}
    before_save :create_gig_payment

    def payment_complete
       self.state = 'paid'
       self.save!
    end

    private

    def create_gig_payment
        if self.state_changed? && self.state == 'completed' && !self.gig_payment
            self.gig_payment = GigPayment.new
            self.gig_payment.save!
        end
    end
end