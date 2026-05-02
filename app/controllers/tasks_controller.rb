class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :check_access

  def create
    @task = @project.tasks.build(task_params)
    @task.user = current_user
    
    if @task.save
      redirect_to project_path(@project), notice: "Task created!"
    else
      redirect_to project_path(@project), alert: @task.errors.full_messages.join(", ")
    end
  end

  def update
    @task = @project.tasks.find(params[:id])
    @task.update(completed: !@task.completed)
    redirect_to project_path(@project), notice: "Task updated!"
  end

  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy
    redirect_to project_path(@project), notice: "Task deleted!"
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

  def task_params
    params.require(:task).permit(:title)
  end
end
