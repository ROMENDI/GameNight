# == Schema Information
#
# Table name: games
#
#  id          :integer          not null, primary key
#  description :text
#  image_url   :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Game < ApplicationRecord
  has_many :events
  validates :title, :description, presence: true
end
