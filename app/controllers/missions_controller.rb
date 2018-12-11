class MissionsController < ApplicationController
  has_scope :category
  has_scope :address
  has_scope :recurrency
  has_scope :time_range

  def index
    @missions = policy_scope(apply_scopes(Mission).all.order(created_at: :desc))
  end

  def show
    @mission = Mission.find(params[:id])
    @organization = @mission.organization
    authorize @mission
  end
end
