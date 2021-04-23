# frozen_string_literal: true

require 'rails_helper'

describe 'POST v1/users', type: :request do
  let!(:user) { create(:user) }

  it 'creates a new user' do
    post '/v1/users', params: { user: { name: 'Israel' } }

    expect(response.code).to eq '201'
  end

  it 'updates user name' do
    put "/v1/users/#{user.id}", params: { user: { name: 'Israel' } }

    expect(response.code).to eq '200'

    record = User.where(name: 'Israel')

    expect(record.count).to eq 1
  end

  it 'destroys user user' do
    delete "/v1/users/#{user.id}"

    expect(response.code).to eq '200'

    record = User.where(name: 'Israel')

    expect(record.count).to eq 0
  end
end
