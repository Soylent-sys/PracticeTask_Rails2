class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:notice] = "登録が完了しました"
      redirect_to users_account_path
    else
      flash.now[:danger] = "入力内容に問題があります"
      render 'new'
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.authenticate(params[:user][:current_password])
      params[:user].delete(:current_password)

      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
      end

      if @user.update(user_params)
        flash[:notice] = "情報が更新されました"
        redirect_to users_account_path
      else
        flash[:danger] = "入力内容に問題があります"
        render 'edit'
      end
    else
      flash[:danger] = "パスワードが間違っています"
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar_icon)
    end
end
