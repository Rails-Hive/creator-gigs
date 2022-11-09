class Gig < ApplicationRecord
    belongs_to :creator
    has_one :gig_payment
    STATES = %i[ applied accepted completed paid]
    enum state: { applied: 0, accepted: 1 , completed: 2, paid: 3} do
        event :accept do
            transition :applied =>  :accepted
        end

        event :complete do
            transition :accepted => :completed
            # after do
            #     create_gig_payment
            # end
        end

        event :pay do
            transition :completed => :paid
        end
    end
     
    validate :applied_state, on: :create
    validates :state, inclusion: { in: states.keys }
    validates :brand_name, presence: true

    validate do
        if @not_valid_state
          errors.add(:state, "Not valid gig state, please select from the list: #{STATES}. Also note that, you can't skip the order of the states")
        end
    end


    before_update :validate_state

    before_update  :create_gig_payment

    scope :like, ->(key, argument){ where("#{key} ILIKE ?", "%#{argument}%") }
    scope :current_state, ->(argument){ where(state: argument) }

    def self.filter(params)
        if params[:brand_name]
            @gigs = self.like("brand_name" ,params[:brand_name])
        else
            @gigs = self.where("creator_id = ?", Creator.like(params[:creator]).pluck(:id))
        end
    end

    def can_change_state(record, state)
        case state
        when "accepted"
            record.can_accept?
        when "completed"
            record.can_complete?
        when "paid"
            record.can_pay?
        else
            true
        end
    end

    def validate_state
        @current = Gig.find(self.id)
        if !can_change_state(@current, self.state) 
            errors.add(state, "The #{self.brand_name} #{@current.state} state can't transition to #{self.state}")
            throw(:abort)
        end
    end

    def state=(value)
        if !STATES.include?(value.to_sym)
          @not_valid_state = true
        else
          super value
        end
    end

    private 

    def create_gig_payment
        if self.state_changed? && self.state == 'completed' && !self.gig_payment
            self.gig_payment = GigPayment.new
            self.gig_payment.save!
        end
    end

    def applied_state 
        if self.state != "applied"
         errors.add(:state, 'The first state for a Gig has to be applied')
        end

    end

end