class ActionPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    @user.present?
  end

  def update?
    @user.present? && (@record.ong == @user.ong)
  end

  def destroy?
    @user.present? && (@record.ong == @user.ong)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
