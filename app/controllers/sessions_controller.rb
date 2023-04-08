class SessionsController < ApplicationController

  before_action :require_login, only: [:destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in(user)
      flash[:notice] = "ログインしました"
      redirect_to users_account_path
    else
      flash.now[:danger] = "メールアドレスかパスワードが間違っています"
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:notice] = "ログアウトしました"
    redirect_to root_path
  end
end
