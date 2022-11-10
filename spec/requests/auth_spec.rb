require 'rails_helper'

describe 'POST / login' do

    scenario 'valid user attributes' do
        @user1 = FactoryBot.create(:user, password: "123456" )
        post '/auth/login', params: {
            email: @user1.email,
            password: @user1.password
        }
        expect(response.status).to eq(200)
    end
  
    scenario 'invalid user attributes' do
        puts @token
      post '/auth/login', params: {
        email: '',
        password: ''
      }
      expect(response.status).to eq(404)
    end
end