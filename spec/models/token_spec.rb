# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Token, type: :model do
  describe '#value' do
    let(:token) { create(:token) }
    let(:secret) { Rails.application.secrets.secret_key_base[0..31] }
    let(:crypt) { ActiveSupport::MessageEncryptor.new(secret) }

    it 'returns encrypted ID' do
      expect(token.value).to be_present
      expect(crypt.decrypt_and_verify(token.value)).to eq token.id
    end
  end
end
