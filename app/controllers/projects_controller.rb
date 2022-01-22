class ProjectsController < ApplicationController
  helper :hot_glue
  include HotGlue::ControllerHelper


  before_action :load_project, only: [:show, :edit, :update, :destroy]
  after_action -> { flash.discard }, if: -> { request.format.symbol ==  :turbo_stream }

  def load_project
    @project = Project.friendly.find(params[:id])
  end


  def load_all_projects
    @projects = Project.page(params[:page])
  end

  def index
    load_all_projects
    respond_to do |format|
       format.html
    end
  end

  def new
    @project = Project.new

    respond_to do |format|
      format.html
    end
  end

  def create
    modified_params = modify_date_inputs_on_params(project_params.dup )
    @project = Project.create(modified_params)

    if @project.save
      flash[:notice] = "Successfully created #{@project.name}"
      load_all_projects
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to projects_path }
      end
    else
      flash[:alert] = "Oops, your project could not be created."
      respond_to do |format|
        format.turbo_stream
        format.html
      end
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def update

    if @project.update(modify_date_inputs_on_params(project_params))
      flash[:notice] = (flash[:notice] || "") << "Saved #{@project.name}"
    else
      flash[:alert] = (flash[:alert] || "") << "Project could not be saved."

    end

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def destroy
    begin
      @project.destroy
    rescue StandardError => e
      flash[:alert] = "Project could not be deleted"
    end
    load_all_projects
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to projects_path }
    end
  end

  def project_params
    params.require(:project).permit( [:name] )
  end

  def default_colspan
    1
  end

  def namespace
    ""
  end
end
