class UsersController < ApplicationController
  # before_action　=> only:で指定されたアクションに対して、事前処理を設定できる
  #1 require_user_logged_in => ログイン状態を確認し、ログインしていれば何もせず、
  #2 ログインしていなければログインページへ強制的にリダイレクトさせる。=> 会員制サービスの開発に流用可能
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
     @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  private
  
  def user_params
     params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end











