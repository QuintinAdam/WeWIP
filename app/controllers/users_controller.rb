class UsersController < ApplicationController

  def index
    authorize! :manage, User
    @users = User.all
  end

  def impersonate
    authorize! :manage, User
    user = User.find(params[:id])
    impersonate_user(user)
    redirect_to root_path
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to root_path
  end
end
