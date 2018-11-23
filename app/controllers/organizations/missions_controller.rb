class Organizations::MissionsController < ApplicationController
  before_action :authenticate_organization!
  before_action :set_organization, only: [:create, :index]
  before_action :set_mission, only: [:show, :edit, :update, :destroy]

  def index
    @coming_missions = coming_organization_missions
    @current_missions = current_organization_missions
    @day_missions = day_organization_missions
  end

  def show
    @users = @mission.users
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(mission_params)
    @mission.organization = @organization

    if @mission.save
      redirect_to organizations_missions_path, :notice => "Votre nouvelle mission a bien été créée!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @mission.update(mission_params)
      redirect_to organizations_mission_path(@mission), :notice => "Vos changements ont été enregistrés!"
    else
      render :edit
    end
  end

  def destroy
    @mission.destroy
    redirect_to organizations_mission_path(@mission), :notice => "Votre mission a été supprimée"
  end

  private

  def set_organization
    @organization = current_organization
  end

  def set_mission
    @mission = Mission.find(params[:id])
  end

  def organization_missions
    @organization.missions
  end

  def coming_organization_missions
    organization_missions.coming
  end

  def current_organization_missions
    organization_missions.current
  end

  def day_organization_missions
    organization_missions.today
  end

  def mission_params
    params.require(:mission).permit(
      :title,
      :address,
      :category,
      :description,
      :skills_needed,
      :volunteers_needed,
      :starting_at,
      :end_candidature_date,
      :duration_in_hours,
      :recurrent
    )
  end
end
