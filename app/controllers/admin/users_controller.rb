class Admin::UsersController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :admin_user

  def index
    @users = User.includes(:tasks).all.order("created_at DESC")
  end

  def new
    @user = User.new
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "userを編集しました"
    else
      redirect_to admin_users_path, notice: "管理者は一人必要です"
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "userを削除しました"  
    else
      redirect_to admin_users_path, notice: "管理者は一人必要です"
    end
  end

  def edit
  end

  def add_admin_role
    @user = User.find(params[:id])
    @user.update_attribute(:admin, true)
    redirect_to admin_users_path, notice: '管理者権限を付与しました。'
  end
  
  def remove_admin_role
    @user = User.find(params[:id])
    @user.update_attribute(:admin, false)
    redirect_to admin_users_path, notice: '管理者権限を削除しました。'
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = '新規登録に成功しました'
      redirect_to admin_user_path(@user)
    else
      render :new
    end
  end

  

  private
  def admin_user
    unless current_user&.admin?
      flash[:alert] = '管理者以外はアクセスできません'
      redirect_to tasks_path
    end
  end

  def set_task
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  
end
