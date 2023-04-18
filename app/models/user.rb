class User < ApplicationRecord
  has_many :rooms
  has_many :reservations

  before_save :email_downcase  # save前にemailを小文字に変換する

  validates :name, presence: true
  #  emailの正規表現を設定
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true, on: :update
  validates :introduction, length: { maximum: 200 }

  has_one_attached :avatar_icon

  private
    # メールアドレスを小文字化する
    def email_downcase
      email.downcase!
    end
end
