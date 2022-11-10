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
    end

    scenario 'valid creator attributes' do
        post '/creators', params: {
            first_name: "Petter",
            last_name: "Parker"
        }, headers:{
            Authorization: @token
        }
        expect(response.status).to eq(200)
        json = JSON.parse(response.body).deep_symbolize_keys
        data = json[:data]

        expect(data[:first_name]).to eq("Petter")
        expect(data[:last_name]).to eq("Parker")
    end
  
    scenario 'invalid creator attributes' do
        puts @token
      post '/creators', params: {
        first_name: '',
        last_name: ''
      }, headers:{
        Authorization: @token
      }
      expect(response.status).to eq(422)
      json = JSON.parse(response.body).deep_symbolize_keys
      
      errors = json[:errors][0]
      expect(errors[:first_name]).to include("can't be blank")
      expect(errors[:last_name]).to include("can't be blank")
    end
end