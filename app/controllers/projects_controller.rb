class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

 def index
    case params[:filter]
    when "created"
      @projects = current_user.projects
    when "shared"
      @projects = current_user.member_projects.where.not(user: current_user)
    else
      @projects = (current_user.projects + current_user.member_projects).uniq
    end
  end

  def show
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to @project, notice: "Project created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project deleted!"
  end

  private

  def set_project
    @project = Project.find(params[:id])
    
    
    unless @project.user == current_user || @project.members.include?(current_user)
      redirect_to projects_path, alert: "You don't have access to this project."
    end
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end