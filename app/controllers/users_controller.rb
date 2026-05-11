class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, only: [:index, :destroy, :toggle_admin]
  before_action :set_user, only: [:show, :destroy, :toggle_admin]

  def index
    @users = User.all.order(:email)
  end

  def show
    @projects = @user.projects
  end

  def destroy
    if @user == current_user
      redirect_to users_path, alert: "You cannot delete yourself!"
      return
    end
    
    @user.destroy
    redirect_to users_path, notice: "User deleted successfully."
  end

  def toggle_admin
    if @user == current_user
      redirect_to users_path, alert: "You cannot change your own admin status!"
      return
    end

    @user.update(is_admin: !@user.is_admin)
    status = @user.is_admin ? "admin" : "regular user"
    redirect_to users_path, notice: "#{@user.email} is now #{status}."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "Only admins can access this page!"
    end
  end
end