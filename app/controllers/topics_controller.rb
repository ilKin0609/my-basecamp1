class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :check_access

  def create
    @topic = @project.topics.build(topic_params)
    @topic.user = current_user
    
    if @topic.save
      redirect_to project_path(@project, anchor: "topic-#{@topic.id}"), notice: "Topic created!"
    else
      redirect_to project_path(@project), alert: @topic.errors.full_messages.join(", ")
    end
  end

  def destroy
    @topic = @project.topics.find(params[:id])
    @topic.destroy
    redirect_to project_path(@project), notice: "Topic deleted!"
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

  def topic_params
    params.require(:topic).permit(:title)
  end
end
