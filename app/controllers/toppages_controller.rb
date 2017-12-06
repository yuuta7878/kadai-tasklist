class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @task = current_user.tasks.build # form_for用 カラのインスタンスを代入
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page]) #一覧表示用
    end
  end  
end
