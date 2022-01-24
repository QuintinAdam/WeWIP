class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  authorize_resource

  def index
    respond_to do |format|

      format.html { render template: "projects/show" }
      format.json {  @messages = @project.messages.order(created_at: :desc)}
    end

  end

  def create
    @project.messages.create(message_params.merge(author: current_user.name, user: current_user))
    render partial: 'messages/form'
  end

  private

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
