json.gigs  @gigs do |gig|
    json.id gig.id
    json.brand_name gig.brand_name
    json.state gig.state
    json.creator_id gig.creator_id
    json.creator_first_name gig.creator.first_name
    json.creator_last_name gig.creator.last_name
end