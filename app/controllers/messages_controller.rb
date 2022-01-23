class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: :create
  def create
    @project.messages.create(message_params.merge(author: current_user.name, user: current_user))
    redirect_to @project
  end

  private

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
