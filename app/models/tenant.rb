# frozen_string_literal: true

# Tenants are authorized users
class Tenant < ActiveRecord::Base
  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = SecureRandom.hex(16)
  end
end
