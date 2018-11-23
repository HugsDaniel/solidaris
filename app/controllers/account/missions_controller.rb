class Account::MissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def index
    @coming_missions = coming_user_missions
    @current_missions = current_user_missions
    @day_missions = day_user_missions
  end

  private

  def set_current_user
    @user = current_user
  end

  def coming_user_missions
    user_missions.coming
  end

  def current_user_missions
    user_missions.current
  end

  def day_user_missions
    user_missions.today
  end

  def user_missions
    @user.missions
  end
end
