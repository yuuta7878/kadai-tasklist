module SessionsHelper
  def current_user # 現在ログインしているユーザを取得するメソッド
  #1 @current_user に既に現在のログインユーザが代入されていたら何もせず、
  #2 代入されていなかったら User.find(...) からログインユーザを取得し、@current_user に代入する処理を1行で書いたもの
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !!current_user # 8.5 sessions#create Helper参照
  end  
end
