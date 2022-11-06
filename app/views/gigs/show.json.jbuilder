
json.gig do
    json.id @gig.id
    json.brand_name @gig.brand_name
    json.state @gig.state
    # json.creator_id @gig.creator_id


    if @relationship == "gig payment" && @gig.gig_payment
        json.gig_payment do
            json.id @gig.gig_payment.id 
            json.state @gig.gig_payment.state 
            json.amount_in_cents @gig.gig_payment.amount_in_cents
        end
    end

    if @relationship == "creator" && @gig.gig_payment
        json.creator do
            json.creator_id @gig.creator_id
            json.creator_first_name @gig.creator.first_name
            json.creator_last_name @gig.creator.last_name
        end
    end
end