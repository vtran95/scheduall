class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true
    validates :name, presence: true

    has_many :attendees
    has_many :attending_events, through: :attendees, source: :event
    has_many :comments
    has_many :events
end
