class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_topic
  before_action :check_access

  def create
    @message = @topic.messages.build(message_params)
    @message.user = current_user
    
    if @message.save
      redirect_to project_path(@project, anchor: "topic-#{@topic.id}"), notice: "Message sent!"
    else
      redirect_to project_path(@project), alert: "Couldn't send message."
    end
  end

  def destroy
    @message = @topic.messages.find(params[:id])
    @message.destroy if @message.user == current_user
    redirect_to project_path(@project), notice: "Message deleted!"
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_topic
    @topic = @project.topics.find(params[:topic_id])
  end

  def check_access
    unless @project.user == current_user || @project.members.include?(current_user)
      redirect_to projects_path, alert: "Access denied!"
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
