# ログインを担当
class SessionsController < ApplicationController
  def new
  end
# params にフォームデータは代入されている
  def create 
    email = params[:session][:email].downcase
    password = params[:session][:password] # 二段階指定
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password) # email,passwordの組み合わせが間違っていた場合には、ログインできない仕様
      # ログイン成功
      session[:user_id] = @user.id # ブラウザにはCookieとして、サーバにはSessionとして、ログイン状態が維持
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
