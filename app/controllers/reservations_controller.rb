class ReservationsController < ApplicationController

  before_action :require_login, only: [:index, :new, :create]

  def index
    @reservations = current_user.reservations
  end

  def new
    @reservation = Reservation.new(reservation_params)
    @reservation[:user_id] = current_user.id
    if @reservation.valid?
      # 合計金額の算出と値の格納
      room = Room.find(reservation_params[:room_id])
      charge = room.price * (@reservation.check_out_date - @reservation.check_in_date) * @reservation.number_of_people
      @reservation[:charge] = charge.to_i
    else
      @room = Room.find(reservation_params[:room_id])
      flash[:danger] = "入力内容に問題があります"
      # 登録失敗時のリロード問題の解決
      redirect_to room_url(@reservation.room_id)
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      flash[:notice] = "予約が確定されました"
      redirect_to reservations_url
    else
      @room = Room.find(reservation_params[:room_id])
      flash[:danger] = "入力内容に問題があります"
      redirect_to room_url(@reservation.room_id)
    end
  end

  def caution
  end

  private

    def reservation_params
      params.require(:reservation).permit(:check_in_date, :check_out_date, :number_of_people, :charge, :user_id, :room_id)
    end
end
