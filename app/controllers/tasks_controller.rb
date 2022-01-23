class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: [:complete]

  def index
    @projects = Project.all
    render template: "projects/show"
  end

  def create
    task = @project.tasks.create(task_params.merge(author: current_user.name, user: current_user))
    if task.save
      @project.messages.create(content: "New: #{task.content}", author: current_user.name, user: current_user)
    end
    render partial: 'tasks/form'
  end

  def complete
    @task.update(completed_at: Time.current)
    @project.messages.create(content: "Completed: #{@task.content}", author: current_user.name, user: current_user)
    render turbo_stream: turbo_stream.remove(@task)
  end

  private

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:task_id])
  end

  def task_params
    params.require(:task).permit(:content, :completed_at)
  end
end
