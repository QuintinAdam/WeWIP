class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def index
    @projects = Project.all
    render template: "projects/show"
  end

  def create
    task = @project.tasks.create(task_params.merge(author: current_user.name, user: current_user))
    if task.save
      @project.messages.create(content: "New Task: #{task.content}", author: current_user.name, user: current_user)
    end
    render partial: 'tasks/form'
  end

  def complete

  end

  private

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:content, :completed_at)
  end
end
