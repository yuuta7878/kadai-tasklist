class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper # => ControllerからHelperのメソッドを使えるようにする処理
  
  private # ログイン要求処理

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_tasks = user.tasks.count
  end
end