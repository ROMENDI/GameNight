# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  bio                    :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  location               :string
#  pfp_url                :string
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :hosted_events, class_name: 'Event', foreign_key: 'host_id', dependent: :destroy
  has_many :reservations, foreign_key: 'sender_id', dependent: :destroy
  has_many :reserved_events, through: :reservations, source: :event


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
