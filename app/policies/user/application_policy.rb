class User::ApplicationPolicy < ApplicationPolicy
  def create?
    true # anyone can apply to a mission
  end
end
