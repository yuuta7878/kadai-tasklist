# ログイン関係を担当
class SessionsController < ApplicationController
  def new
  end
# params にフォームデータは代入されている
  def create 
    # 取り出す時の二段階指定して取得
    email = params[:session][:email].downcase #フォームデータの email を小文字化して取得
    password = params[:session][:password] 
    if login(email, password) # ログイン可能なメソッドが定義、ログインに成功すればtrueを返し、失敗すればfalseを返す仕様
      flash[:success] = 'ログインに成功しました。'
      # 成功時、@userのusers#showへとリダイレクト
      redirect_to @user 
    else
      # 失敗時、render 'new'によりsessions/new.html.erbを再表示する
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end

  def destroy # ログアウト機能
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url # ログアウト後は、TOPにリダイレクトさせる。
  end
  
  # login(email, passsword) をprivateで定義
  private
  
  def login(email, password)
    @user = User.find_by(email: email) # 入力フォームのemailと同じメアドを持つユーザを検索し@userへ代入
    #  if @userで @userが存在するかを確認している。
    if @user && @user.authenticate(password) # @userのパスワードが合っているか、email,passwordの組み合わせが間違っていた場合には、ログインできない仕様
      # ログイン成功
      session[:user_id] = @user.id # ブラウザにはCookieとして、サーバにはSessionとして、ログイン状態が維持
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
