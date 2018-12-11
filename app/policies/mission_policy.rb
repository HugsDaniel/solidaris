class MissionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true # anyone can view the missions
  end

  def show?
   true # anyone can view a mission
  end
end
