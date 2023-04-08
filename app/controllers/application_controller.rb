class ApplicationController < ActionController::Base
  # セッション用のヘルパーをアプリケーション(全コントローラ)で使用できるようにする
  include SessionsHelper
end
