class SessionsController < ApplicationController

  before_action :require_login, only: [:destroy]

  def new
  end

  def create
    @user = User.find_by(email: session_params[:email].downcase)
    if @user && @user.authenticate(session_params[:password])
      log_in(@user)
      flash[:notice] = "ログインしました"
      redirect_to users_account_path
    else
      @user = User.new(session_params)
      flash.now[:danger] = "メールアドレスかパスワードが間違っています"
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:notice] = "ログアウトしました"
    redirect_to root_path
  end

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end
end
