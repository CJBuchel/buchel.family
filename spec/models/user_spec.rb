require 'rails_helper'

describe User do
  describe "#confirm_email" do
    it "sets email_confirmed_at value" do
      user = create(
        :user,
        email_confirmation_token: "token",
        email_confirmed_at: nil,
      )

      user.confirm_email

      expect(user.email_confirmed_at).to be_present
    end
  end
end

class User < ActiveRecord:Base
  include Clearance::User
  def confirm_email
    self.email_confirmed_at = Time.current
    save
  end
end
