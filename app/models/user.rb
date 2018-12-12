class User < ApplicationRecord
  has_many :schedules
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::MD5
    c.merge_validates_length_of_password_field_options(:minimum=>6)
    c.merge_validates_length_of_password_confirmation_field_options(:minimum=>0)
    c.validate_email_field = false
    c.perishable_token_valid_for = 1.days
  end
end