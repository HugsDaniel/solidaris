class Admin::MissionPolicy < ApplicationPolicy
  def new?
    true
  end

  def show?
    record.manager == user
  end

  def create?
    record.manager == user
  end

  def update?
    record.manager == user
  end

  def destroy?
    record.manager == user
  end
end
