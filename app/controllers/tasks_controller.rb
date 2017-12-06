class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # ログインしているユーザーの、全タスクを取得する
    @tasks = current_user.tasks.all
  end
  
  def show
  end
  
  def new
    @task = current_user.tasks.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    # binding.pry # こう書くと、ここで、処理が一度止まります
    if @task.save
      flash[:success] = 'Taskが正常に投稿されました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'Taskの投稿に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = 'Taskは正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  def edit
    # モデル名は「1文字目が大文字」かつ「単数形」で表記します
    # なので Task になります
    # models/task.rb の「クラス名」と一致しています
    # @task = Task.find(params[:id])
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'task は更新されませんでした'
      render :edit
    end
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status, :user_idm)
  end
  
  def correct_user # 削除しようとしているMicropostが本当にログインユーザが所有しているものかを確認している。
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url #見つからなければトップページに戻されます。
    end
  end
end













