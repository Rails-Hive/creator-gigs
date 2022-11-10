require 'rails_helper'

describe 'POST / creator' do

    before do
        @user1 = FactoryBot.create(:user, password: "123456" )
        post '/auth/login', params: {
            email: @user1.email,
            password: @user1.password
        }
        json = JSON.parse(response.body).deep_symbolize_keys
        @token = json[:token]

        @creator = FactoryBot.create(:creator)
    end

    scenario 'valid gig attributes' do
        post '/gigs', params: {
            brand_name: "Spiderman",
            creator_id: @creator.id
        }, headers:{
            Authorization: @token
        }
        expect(response.status).to eq(200)
        json = JSON.parse(response.body).deep_symbolize_keys
        data = json[:data]

        expect(data[:brand_name]).to eq("Spiderman")
    end
  
    scenario 'invalid gig attributes' do
        puts @token
      post '/gigs', params: {
        brand_name: '',
        creator_id: ''
      }, headers:{
        Authorization: @token
      }
      
      expect(response.status).to eq(422)
      json = JSON.parse(response.body).deep_symbolize_keys
      errors = json[:errors][0]
      
      expect(errors[:brand_name]).to include("can't be blank")
      expect(errors[:creator]).to include("must exist")
    end
end