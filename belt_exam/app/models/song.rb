class Song < ActiveRecord::Base
    has_many :likes, class_name: "Liked", foreign_key: :song_id
    has_many :liked_by_users, through: :likes, source: :user
    validates :title, :artist, presence: true, length: { minimum: 2 }
end
