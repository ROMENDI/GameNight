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
#  sender_id  (sender_id => senders.id)
#
class Reservation < ApplicationRecord
  belongs_to :sender
  belongs_to :event
  enum status: { yes: 0, maybe: 1 }
end
