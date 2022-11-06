class Gig < ApplicationRecord
    belongs_to :creator
    has_one :gig_payment
    enum state: { applied: 0, accepted: 1 , completed: 2, paid: 3}
    before_save :create_gig_payment

    scope :like, ->(key, argument){ where("#{key} ILIKE ?", "%#{argument}%") }
    scope :current_state, ->(argument){ where(state: argument) }

    def payment_complete
       self.state = 'paid'
       self.save!
    end

    def self.filter(params)
        if params[:brand_name]
            @gigs = self.like("brand_name" ,params[:brand_name])
        else
            @gigs = self.where("creator_id = ?", Creator.like(params[:creator]).pluck(:id))
        end
    end

    private


    def create_gig_payment
        if self.state_changed? && self.state == 'completed' && !self.gig_payment
            self.gig_payment = GigPayment.new
            self.gig_payment.save!
        end
    end
end