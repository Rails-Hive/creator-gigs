FactoryBot.define do
    factory(:user) do
      name {Faker::Name.name} 
      username {Faker::Internet.username } 
      email { Faker::Internet.email }
      password { Faker::Internet.password}
    end

    factory(:creator) do
        first_name {Faker::Name.first_name} 
        last_name {Faker::Name.last_name} 
    end

    factory(:gig) do
        brand_name {Faker::Company.name} 
        creator_id {1}
    end
end