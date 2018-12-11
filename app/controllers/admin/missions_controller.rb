class Admin::MissionsController < AdminController
  before_action :authenticate_user!
  before_action :set_organization
  before_action :set_mission, only: [:show, :edit, :update, :destroy]

  has_scope :start
  has_scope :category
  has_scope :address
  has_scope :recurrency
  has_scope :time_range

  def index
    @missions = policy_scope(apply_scopes(@organization.missions).all.order(starting_at: :asc))
    # @coming_missions = coming_organization_missions
    # @current_missions = current_organization_missions
    # @day_missions = day_organization_missions
  end

  def show
    @users = @mission.users
  end

  def new
    @mission = Mission.new
    authorize @mission
  end

  def create
    @mission = Mission.new(mission_params)
    @mission.organization = @organization
    authorize @mission

    if @mission.save
      redirect_to admin_organization_missions_path(@organization), :notice => "Votre nouvelle mission a bien été créée!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @mission.update(mission_params)
      redirect_to admin_organization_missions_path(@organization), :notice => "Vos changements ont été enregistrés!"
    else
      render :edit
    end
  end

  def destroy
    @mission.destroy
    redirect_to admin_organization_missions_path(@organization), :notice => "Votre mission a été supprimée"
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_mission
    @mission = Mission.find(params[:id])
    authorize @mission
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
