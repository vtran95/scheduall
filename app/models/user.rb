class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true
    validates :name, presence: true

    has_many :attendees, dependent: :destroy
    has_many :attending_events, through: :attendees, source: :event
    has_many :comments, dependent: :destroy
    has_many :events, dependent: :destroy
end
