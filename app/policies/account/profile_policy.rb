class Account::ProfilePolicy < ApplicationPolicy
  def show?
    record == user
  end

  def update?
    record == user
  end
end
