# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  capacity    :integer
#  date_time   :datetime
#  description :text
#  location    :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  game_id     :integer          not null
#  host_id     :integer          not null
#
# Indexes
#
#  index_events_on_game_id  (game_id)
#  index_events_on_host_id  (host_id)
#
# Foreign Keys
#
#  game_id  (game_id => games.id)
#  host_id  (host_id => users.id)
#
class Event < ApplicationRecord
  belongs_to :game
  belongs_to :host, class_name: 'User', foreign_key:'host_id'
  has_many :reservations
  validates :title, :date_time, presence: true
  validates :capacity, numericality: { greater_than_or_equal_to: 1, only_integer: true }
end

