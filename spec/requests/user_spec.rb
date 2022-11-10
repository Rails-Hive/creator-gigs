require 'rails_helper'

describe 'POST /user' do
    # 'scenario' is similar to 'it', use which you see fit
    
    scenario 'valid user attributes' do
      # send a POST request to /users, with these parameters
      # The controller will treat them as JSON 
        post '/users', params: {
          name: 'Ruby Guy',
          username: 'ruby_guy',
          email: 'rubyguy@test.com',
          password: '123456'
        }
      # response should have HTTP Status 201 Created
      expect(response.status).to eq(201)
  
      json = JSON.parse(response.body).deep_symbolize_keys
      
      # check the value of the returned response hash
      expect(json[:name]).to eq('Ruby Guy')
      expect(json[:username]).to eq('ruby_guy')
      expect(json[:email]).to eq('rubyguy@test.com')
  
      # 1 new user record is created
      expect(User.count).to eq(2)
  
      # Optionally, you can check the latest record data
      expect(User.last.name).to eq('Ruby Guy')
    end
  
    scenario 'invalid user attributes' do
      post '/users', params: {
        user: {
          name: '',
          username: '',
          email: '',
          password: ''
        }
      }
  
      # response should have HTTP Status 201 Created
      expect(response.status).to eq(422)
  
      json = JSON.parse(response.body).deep_symbolize_keys
      errors = json[:errors]
      expect(errors).to include("Name can't be blank")
      expect(errors).to include("Email can't be blank")
      expect(errors).to include("Email is invalid")
      expect(errors).to include("Password is too short (minimum is 6 characters)")
  
      # no new user record is created
      expect(User.count).to eq(1)
    end
end

describe 'GET /users' do

    before do
        @user1 = FactoryBot.build(:user, password: "123456" )
        post '/users', params: {
            email: @user1.email,
            password: '123456'
          }
          json = JSON.parse(response.body).deep_symbolize_keys
        @token = json[:token]
    end
    
    scenario 'Unauthorize users' do
        get '/users'
        json = JSON.parse(response.body).deep_symbolize_keys
        error = json[:errors][0]

        expect(error[:title]).to eq("Unauthorized")
        expect(error[:detail]).to eq("Missing or invalid Token")
        expect(error[:status]).to eq(401)

    end

    scenario 'returns users' do
        get '/users', headers: {
            Authorization: @token
        }
        json = JSON.parse(response.body).deep_symbolize_keys
        puts json

    end
end