class Messages::ShowBySenderSerializer < MessageSerializer
  belongs_to :sender
  has_many :receivers
end
