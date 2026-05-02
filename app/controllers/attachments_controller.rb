class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :check_access

  def create
    if params[:files].present?
      params[:files].each do |file|
        @project.attachments.attach(file)
      end
      redirect_to project_path(@project), notice: "File(s) uploaded!"
    else
      redirect_to project_path(@project), alert: "Please choose a file."
    end
  end

  def destroy
    attachment = @project.attachments.find(params[:id])
    attachment.purge
    redirect_to project_path(@project), notice: "File deleted!"
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def check_access
    unless @project.user == current_user || @project.members.include?(current_user)
      redirect_to projects_path, alert: "Access denied!"
    end
  end
end