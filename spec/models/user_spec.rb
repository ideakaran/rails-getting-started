require 'rails_helper'

RSpec.describe User, type: :model do
  it 'returns user created by factorybot' do
    # user = User.create(username: 'abcd')
    user = build(:user)
    expect(user.username).to eq 'karan'
    expect(user.user_type).to eq 'admin'
  end

  it 'should validate presence of attributes' do
    user = build :user, username: nil, user_type: nil
    pp user
    expect(user).not_to be_valid
    expect(user.errors.messages[:username]).to include("can't be blank")
    expect(user.errors.messages[:user_type]).to include("can't be blank")
  end

  it 'should validate uniqueness of username' do
    user = create :user
    user2 = build :user, username: user.username
    expect(user2).not_to be_valid
    expect(user2.errors.messages[:username]).to include("has already been taken")

    user2.username = 'Random'
    expect(user2).to be_valid
  end
end