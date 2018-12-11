class Account::ProfilePolicy < ApplicationPolicy
  def update?
    record == user
  end
end
