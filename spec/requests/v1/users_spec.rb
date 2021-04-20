require 'rails_helper'

describe 'POST v1/users', type: :request do
  it 'creates a new user' do
    post '/v1/users', params: { name: 'Israel' }

    expect(response.code).to eq '201'
  end

  it "updates user name" do
    user = create(:user)

    put "/v1/users/#{user.id}", params: { name: 'Israel' }

    expect(response.code).to eq '201'

    record = User.where(name: 'Israel')

    expect(record.count).to eq 1
  end
end
