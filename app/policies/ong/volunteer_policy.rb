class Ong::VolunteerPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def confirm_presence?
    @user.present? && (@record.ong == @user.ong)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
