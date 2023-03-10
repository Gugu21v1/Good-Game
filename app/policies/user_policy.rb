class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.id == user.id
    # record: the restaurant passed to the `authorize` method in controller
    # user: the `current_user` signed in with Devise
  end
end
