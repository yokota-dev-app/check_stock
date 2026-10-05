class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user # ビュー側でもそのまま使えるメソッド
  before_action :require_login

  def logged_in?
    !!current_user # 二重否定とすることでUserオブジェクト（真値）の場合は true に、nil（偽値）の場合は false
  end

  def logout
    session[:user_id] = nil
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  private

  def require_login
    redirect_to login_path unless logged_in?
  end
end
