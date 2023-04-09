class UsersController < ApplicationController

  before_action :require_login, only: [:show, :edit, :update]

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
    # リクエストURLに応じて呼び出す詳細ページのURLを分岐させる
    @url = request.fullpath + '_show'
  end

  def edit
    @user = current_user
    sent_url = request.fullpath
    # リクエストURLに応じて呼び出す部分パーシャルのURLを分岐させる
    if sent_url === '/users/edit'
      @url = 'users/account_edit'
    else sent_url === '/users/profile/edit'
      @url = 'users/profile_edit'
    end
  end

  def update
    sent_url = request.fullpath
    # リクエストURLに応じてアカウント情報かプロフィール情報の更新処理に分岐させる
    if sent_url === '/users/edit'
      @user = current_user
      if @user.authenticate(params[:user][:current_password])
        # パスワード認証後は current_password は必要無いのでparamsによる送信対象から削除
        params[:user].delete(:current_password)

        # パスワードの変更フォームが空欄の場合はパスワード関連のカラムをparamsによる送信対象から外す
        if user_params[:password].blank?
          user_params.delete(:password)
          user_params.delete(:password_confirmation) if user_params[:password_confirmation].blank?
        end

        if @user.update(user_params)
          flash[:notice] = "アカウント情報が更新されました"
          redirect_to users_account_path
        else
          @url = 'users/account_edit'
          flash[:danger] = "入力内容に問題があります"
          render 'edit'
        end
      else
        @url = 'users/account_edit'
        flash[:danger] = "パスワードが間違っています"
        render 'edit'
      end
    elsif sent_url === '/users/profile/edit'
      @user = current_user
      if @user.update(user_params)
        flash[:notice] = "プロフィール情報が更新されました"
        redirect_to users_profile_path
      else
        @url = 'users/profile_edit'
        flash[:danger] = "入力内容に問題があります"
        render 'edit'
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :avatar_icon)
    end
end
