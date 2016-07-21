class Device < ApplicationRecord
  belongs_to :user
  has_one :session
  enum device_type: [:android, :ios]
end
