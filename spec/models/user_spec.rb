require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
      it 'is valid with valid attributes' do
        user = User.new(email: 'test@test.com', password: 'password', password_confirmation: 'password', first_name: 'John', last_name: 'Doe')
        expect(user).to be_valid
      end

      it 'is not valid without a password' do
        user = User.new(email: 'test@test.com', first_name: 'John', last_name: 'Doe')
        expect(user).to_not be_valid
      end

      it 'is not valid when password does not match password confirmation' do
        user = User.new(email: 'test@test.com', password: 'password', password_confirmation: 'password1', first_name: 'John', last_name: 'Doe')
        expect(user).to_not be_valid
      end

      it 'is not valid without a unique email' do
        User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password', first_name: 'John', last_name: 'Doe')
        user = User.new(email: 'TEST@TEST.COM', password: 'password', password_confirmation: 'password', first_name: 'Jane', last_name: 'Doe')
        expect(user).to_not be_valid
      end

      it 'is not valid without an email' do
        user = User.new(password: 'password', password_confirmation: 'password', first_name: 'John', last_name: 'Doe')
        expect(user).to_not be_valid
      end

      it 'is not valid without a first name' do
        user = User.new(email: 'test@test.com', password: 'password', password_confirmation: 'password', last_name: 'Doe')
        expect(user).to_not be_valid
      end

      it 'is not valid without a last name' do
        user = User.new(email: 'test@test.com', password: 'password', password_confirmation: 'password', first_name: 'John')
        expect(user).to_not be_valid
      end

      it 'is not valid with a password less than 6 characters long' do
        user = User.new(email: 'test@test.com', password: 'short', password_confirmation: 'short', first_name: 'John', last_name: 'Doe')
        expect(user).to_not be_valid
      end 
  end

    describe '.authenticate_with_credentials' do
      it 'authenticates with correct email and password' do
        user = User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password', first_name: 'John', last_name: 'Doe')
        authenticated_user = User.authenticate_with_credentials('test@test.com', 'password')
        expect(authenticated_user).to eq(user)
      end

      it 'does not authenticate with incorrect password' do
        user = User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password', first_name: 'John', last_name: 'Doe')
        authenticated_user = User.authenticate_with_credentials('test@test.com', 'wrongpassword')
        expect(authenticated_user).to be_nil
      end

      it 'authenticates with correct email with mixed case and password' do
        user = User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password', first_name: 'John', last_name: 'Doe')
        authenticated_user = User.authenticate_with_credentials('TEST@tEst.com', 'password')
        expect(authenticated_user).to eq(user)
      end

      it 'authenticates with correct email with leading/trailing spaces and password' do
        user = User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password', first_name: 'John', last_name: 'Doe')
        authenticated_user = User.authenticate_with_credentials(' test@test.com ', 'password')
        expect(authenticated_user).to eq(user)
      end

      it 'authenticates when email has leading or trailing white spaces' do
        user = User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password', first_name: 'John', last_name: 'Doe')
        authenticated_user = User.authenticate_with_credentials('   test@test.com  ', 'password')
        expect(authenticated_user).to eq(user)
      end

      it 'authenticates when email is typed in the wrong case' do
        user = User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password', first_name: 'John', last_name: 'Doe')
        authenticated_user = User.authenticate_with_credentials('TEST@TEST.COM', 'password')
        expect(authenticated_user).to eq(user)
      end
  end
end
