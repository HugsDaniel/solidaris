class Admin::OrganizationPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(manager: user)
    end
  end

  def show?
    record.manager == user
  end

  def create?
    true
  end

  def update?
    record.manager == user
  end
end
