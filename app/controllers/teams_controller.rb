class TeamsController < ApplicationController
  helper :hot_glue
  include HotGlue::ControllerHelper

  before_action :authenticate_user!

  before_action :load_team, only: [:show, :edit, :update, :destroy]
  after_action -> { flash.discard }, if: -> { request.format.symbol ==  :turbo_stream }

  def load_team
    @team = current_user.teams.friendly.find(params[:id])
  end

  def load_all_teams
    @teams = current_user.teams.page(params[:page])
  end

  def index
    load_all_teams
    respond_to do |format|
       format.html
    end
  end

  def new
    @team = Team.new(owner: current_user)

    respond_to do |format|
      format.html
    end
  end

  def create
    modified_params = modify_date_inputs_on_params(team_params.dup.merge!(owner: current_user ) , current_user)
    @team = Team.create(modified_params)

    if @team.save
      flash[:notice] = "Successfully created #{@team.name}"
      # adds current_user as an admin mean member
      current_user.team_members.create(team: @team, role: [:admin])
      load_all_teams
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to teams_path }
      end
    else
      flash[:alert] = "Oops, your team could not be created."
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

    if @team.update(modify_date_inputs_on_params(team_params, current_user))
      flash[:notice] = (flash[:notice] || "") << "Saved #{@team.name}"
    else
      flash[:alert] = (flash[:alert] || "") << "Team could not be saved."
    end

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def destroy
    begin
      @team.destroy
    rescue StandardError => e
      flash[:alert] = "Team could not be deleted"
    end
    load_all_teams
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to teams_path }
    end
  end

  def team_params
    params.require(:team).permit( [:name, :slug] )
  end

  def default_colspan
    2
  end

  def namespace
    ""
  end
end
