class User < ApplicationRecord
  before_save :email_downcase  # save前にemailを小文字に変換する
  #  emailの正規表現を設定
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, presence: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }#,
                    #uniqueness: { case_sensitive: false }  # Rails6.1以降は不要？
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true, on: :update
  has_secure_password

  has_one_attached :avatar_icon

  private
    # メールアドレスを小文字化する
    def email_downcase
      email.downcase!
    end
end
