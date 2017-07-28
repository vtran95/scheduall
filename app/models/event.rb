class Event < ApplicationRecord
    validates :title, presence: true
    validates :start_date, presence: true

    belongs_to :user
    has_many :attendees, dependent: :destroy
    has_many :attending_users, through: :attendees, source: :user
    has_many :comments, dependent: :destroy
end
