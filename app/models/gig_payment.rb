class GigPayment < ApplicationRecord
    belongs_to :gig
    enum state: { pending: 0, complete: 1}
    before_save :change_gig_state

    def change_gig_state
       self.gig.payment_complete if self.state_changed? && self.state == 'complete' 
    end
end