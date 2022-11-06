
20.times do
    Creator.create!({
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
    })
end

puts "20 creators created"

@creators = Creator.all
@creators.each do |creator|
    2.times do
        creator.gigs << Gig.new(brand_name: Faker::Company.name)
    end
end


puts "40 gigs created"