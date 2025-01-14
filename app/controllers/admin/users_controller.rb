class Admin::UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create 
    @user = User.new(user_params)
    
    if @user.save 
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new 
    end

  end 
  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def update
   @user = User.find(params[:id])

   if @user.update(user_params)
    redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を更新しました"
   else
    render :new
   end

   def destroy 
    @user = User.find(params[:id])
    @user.destroy 
    redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を削除しました"
   end

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
  
end
