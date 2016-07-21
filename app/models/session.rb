class Session < ApplicationRecord

  include Tokenable

  belongs_to :device
  before_create :set_expire_at

  def set_expire_at
    self.expire_at = Time.zone.now + 2.days
  end

  def expired?
    self.expire_at < Time.zone.now
  end

end
