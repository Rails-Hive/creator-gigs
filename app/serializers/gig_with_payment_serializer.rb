class GigWithPaymentSerializer < ActiveModel::Serializer
    attributes :id, :brand_name, :state, :gig_payment
    belongs_to :creator

    def gig_payment
        {
            id: object.gig_payment.id,
            state:  object.gig_payment.state,
            amount_in_cents:  object.gig_payment.amount_in_cents
        }
    end
end