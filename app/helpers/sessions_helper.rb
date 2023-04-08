module SessionsHelper

  # 引数で渡されたユーザーでsessionを構築（ログイン）する
  def log_in(user)
    session[:user_id] = user.id
  end

  # sessionが構築されている（ログインしている）場合は、
  # そのユーザーを（DBで検索して）インスタンス変数に格納する
  # インスタンスに値が存在する場合はその値のままにする
  # 無駄なDB検索をさせないための制御
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # sessionの状態（ログイン状態かどうか）の論理値を返す
  # current_user が存在していれば（nilじゃなければ） true を、
  # 存在していなければ(nilであれば) false を返す
  def logged_in?
    !current_user.nil?
  end

  # ログイン状態じゃなければ、ログインページにリダイレクトする
  def require_login
    if !logged_in?
      flash[:danger] = "ログイン後にアクセスできます"
      redirect_to log_in_path
    end
  end

  # セッションを削除（ログアウト）する
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
