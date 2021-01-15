# frozen_string_literal: true

class Token < ApplicationRecord
  def value
    secret = Rails.application.secrets.secret_key_base || ENV['SECRET_KEY_BASE']
    secret = secret[0..31]
    crypt = ActiveSupport::MessageEncryptor.new(secret)
    crypt.encrypt_and_sign(id)
  end
end
