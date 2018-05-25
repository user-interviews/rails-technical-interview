# frozen_string_literal: true

class UserRememberToken < ActiveRecord::Base
  validates_presence_of :last_used_at, :token_digest

  belongs_to :user, required: true

  def trigger_used!
    update_attributes!(last_used_at: Time.zone.now)
  end

  def self.create_digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.create_token_for_user!(user)
    token = SecureRandom.urlsafe_base64

    create!(
      user: user,
      token_digest: create_digest(token),
      last_used_at: Time.zone.now,
    )

    token
  end

  def self.find_valid_token(user_id, token)
    includes(:user)
      .where(arel_table[:last_used_at].gt(Time.zone.now - ttl))
      .find_by(
        user_id: user_id,
        token_digest: create_digest(token),
      )
  end

  private_class_method
  def self.ttl
    30.days
  end
end
