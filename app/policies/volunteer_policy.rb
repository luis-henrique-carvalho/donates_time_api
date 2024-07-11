class VolunteerPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    true
  end

  def create?
    @user.present?
  end

  def destroy?
    @user.present? && (@record.user == @user)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
