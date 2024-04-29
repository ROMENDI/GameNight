# == Schema Information
#
# Table name: reservations
#
#  id         :integer          not null, primary key
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :integer          not null
#  sender_id  :integer          not null
#
# Indexes
#
#  index_reservations_on_event_id   (event_id)
#  index_reservations_on_sender_id  (sender_id)
#
# Foreign Keys
#
#  event_id   (event_id => events.id)
#  sender_id  (sender_id => users.id)
#
class Reservation < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :event
  enum status: { yes: 0, maybe: 1 }
  validates :status, presence: true
  validates :sender_id, uniqueness: { scope: :event_id, message: "You have already made a reservation for this event." }
  validate :host_cannot_reserve

  private 

  # Prevents event host from reserving their own event 
  def host_cannot_reserve
    if event.host == sender_id
      errors.add(:base, "Hosts cannot reserve their own event")
    end
  end
end
