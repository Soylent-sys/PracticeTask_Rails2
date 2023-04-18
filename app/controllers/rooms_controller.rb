class RoomsController < ApplicationController

  before_action :require_login, only: [:create]

  def index
    @rooms = Room.where("address LIKE ? AND details LIKE ?", "%#{params[:area]}%", "%#{params[:keyword]}%")
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:notice] = "施設が登録されました"
      redirect_to room_path(@room.id)
    else
      flash.now[:danger] = "入力内容に問題があります"
      render 'new'
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def own
    @rooms = Room.where(user_id: current_user.id)
  end

  private
    def room_params
      params.require(:room).permit(:name, :details, :price, :address, :room_image, :user_id)
    end
end
