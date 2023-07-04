require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'validates when all fields are present and password equals password_confirmation' do
      user = User.new(password: 'password', password_confirmation: 'password', email: 'test@test.com', firstname: 'John', lastname: 'Doe')
      expect(user).to be_valid
    end

    it 'fails validation when password and password_confirmation do not match' do
      user = User.new(password: 'password', password_confirmation: 'different_password', email: 'test@test.com', firstname: 'John', lastname: 'Doe')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'fails validation when email is not unique' do
      User.create(password: 'password', password_confirmation: 'password', email: 'TEST@TEST.com', firstname: 'John', lastname: 'Doe')
      user2 = User.new(password: 'password', password_confirmation: 'password', email: 'test@test.com', firstname: 'John', lastname: 'Doe')
      expect(user2).to_not be_valid
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'fails validation when password is below the minimum length' do
      user = User.new(password: 'pass', password_confirmation: 'pass', email: 'test@test.com', firstname: 'John', lastname: 'Doe')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'authenticates when credentials are correct' do
      user = User.create(password: 'password', password_confirmation: 'password', email: 'test@test.com', firstname: 'John', lastname: 'Doe')
      expect(User.authenticate_with_credentials('test@test.com', 'password')).to eq(user)
    end

    it 'does not authenticate when password is incorrect' do
      User.create(password: 'password', password_confirmation: 'password', email: 'test@test.com', firstname: 'John', lastname: 'Doe')
      expect(User.authenticate_with_credentials('test@test.com', 'wrongpassword')).to be_nil
    end

    it 'authenticates when email has leading or trailing spaces' do
      user = User.create(password: 'password', password_confirmation: 'password', email: 'test@test.com', firstname: 'John', lastname: 'Doe')
      expect(User.authenticate_with_credentials('  test@test.com  ', 'password')).to eq(user)
    end

    it 'authenticates when email case is incorrect' do
      user = User.create(password: 'password', password_confirmation: 'password', email: 'test@test.com', firstname: 'John', lastname: 'Doe')
      expect(User.authenticate_with_credentials('TEST@TEST.COM', 'password')).to eq(user)
    end
  end
end
