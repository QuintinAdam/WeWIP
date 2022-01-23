class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  authorize_resource
  respond_to :html

  def index
    @projects = Project.all
    respond_with(@projects)
  end

  def show
    @projects = Project.all
    respond_with(@project)
  end

  def new
    @project = Project.new
    respond_with(@project)
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    flash[:notice] = 'Project was successfully created.' if @project.save
    respond_with(@project)
  end

  def update
    flash[:notice] = 'Project was successfully updated.' if @project.update(project_params)
    respond_with(@project)
  end

  def destroy
    @project.destroy
    respond_with(@project)
  end

  private
    def set_project
      @project = Project.friendly.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name)
    end
end
