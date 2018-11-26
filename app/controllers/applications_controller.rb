class ApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mission

  def create
    @application = Application.new

    @application.user_id = @user.id
    @application.mission_id = @mission.id

    if @application.save
      redirect_to account_missions_path
    else
      redirect_to @mission, notice: "Mmh, ça n'a pas fonctionné..."
    end
  end

  private

  def set_mission
    @mission = Mission.find(params[:mission_id])
  end
end
