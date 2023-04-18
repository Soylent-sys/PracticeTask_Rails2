class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in_date, presence: true,
            format: { with: /\A\d{4}\-\d{2}\-\d{2}\Z/, message: "YYYY/MM/DDのフォーマットではありません" }
  validates :check_out_date, presence: true,
            format: { with: /\A\d{4}\-\d{2}\-\d{2}\Z/, message: "YYYY/MM/DDのフォーマットではありません" }
  validates :number_of_people, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :charge, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true, on: :create
  validates :user_id, presence: true
  validates :room_id, presence: true
  validate :check_in_out_check  # チェックアウト日がチェックイン日以前に設定された場合の制御

  # 以下メソッド
  def check_in_out_check
    if self.check_in_date === nil || self.check_out_date === nil
      return
    elsif self.check_in_date > self.check_out_date
      errors.add(:check_out_date, "チェックアウト日はチェックイン日よりも後に設定してください")
    end
  end

end
