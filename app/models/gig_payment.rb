class GigPayment < ApplicationRecord
    belongs_to :gig
    enum state: { pending: 0, complete: 1} do
        event :completed do
            transition :pending => :complete
            after do
                self.gig.pay
            end
        end
    end

    scope :current_state, ->(argument){ where(state: argument) }
end