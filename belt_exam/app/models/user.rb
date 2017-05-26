class User < ActiveRecord::Base
  has_secure_password

  EMAIL_REGEX = /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i

  has_many :liked_songs, class_name: "Liked", foreign_key: :user_id
  has_many :liked_songs_info, through: :liked_songs, source: :song

  before_validation :downcase_email
  validates :email, uniqueness: true, format: { with: EMAIL_REGEX, message: "Please enter a valid email" }
  validates :first_name, :last_name, :email, :password, presence: true

  private
    def downcase_email
        self.email.downcase!
    end



end
