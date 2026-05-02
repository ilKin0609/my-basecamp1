class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :check_admin

  def create
    user = User.find_by(email: params[:email])
    
    if user.nil?
      redirect_to edit_project_path(@project), alert: "User not found with this email."
      return
    end

    is_admin = params[:is_admin] == "1" || params[:is_admin] == "true"
    membership = @project.memberships.build(user: user, is_admin: is_admin)
    
    if membership.save
      redirect_to edit_project_path(@project), notice: "Member added successfully!"
    else
      redirect_to edit_project_path(@project), alert: "Couldn't add member (maybe already a member?)."
    end
  end

  def update
    membership = @project.memberships.find(params[:id])
    membership.update(is_admin: !membership.is_admin)
    redirect_to edit_project_path(@project), notice: "Admin status updated!"
  end

  def destroy
    membership = @project.memberships.find(params[:id])
    membership.destroy
    redirect_to edit_project_path(@project), notice: "Member removed!"
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def check_admin
    unless @project.admin?(current_user)
      redirect_to projects_path, alert: "Only admins can manage members!"
    end
  end
end