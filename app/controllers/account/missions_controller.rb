class Account::MissionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @coming_missions = coming_user_missions
    @current_missions = current_user_missions
    @day_missions = day_user_missions
  end

  private

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
