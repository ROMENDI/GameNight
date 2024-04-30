# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  capacity    :integer
#  date_time   :datetime
#  description :text
#  latitude    :float
#  location    :string
#  longitude   :float
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  game_id     :integer
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
  #geocoded_by :location
  #after_validation :geocode, if: ->(obj){ obj.location.present? and obj.location_changed? }

  #Associations
  belongs_to :game, optional: true
  belongs_to :host, class_name: 'User', foreign_key:'host_id'
  has_many :reservations, dependent: :destroy

  #Validations
  validates :title, :date_time, presence: true
  validates :date_time, presence: true
  validates :location, presence: true
  validates :capacity, numericality: { greater_than_or_equal_to: 1, only_integer: true }

  #Scopes

  #Exclude events hosted by current user
  scope :excluding_host, ->(user_id) { where.not(host_id: user_id) }
  #Exclude events reserved by current user 
  scope :excluding_reserved, ->(user_ids) { where.not(id: user_ids) }

  scope :by_date, ->(date) { where("DATE(date_time) = ?", Date.parse(date)) if date.present? }
  scope :by_location, ->(location) { where("location LIKE ?", "%#{location}%") if location.present? }
  scope :by_capacity, ->(capacity) { where("capacity >= ?", capacity.to_i) if capacity.present? }
  
  # Handles geocoding errors
  def geocode
    super
  rescue StandardError => e
    errors.add(:base, "Geocoding failed: #{e.message}")
  end
  
end
