class User::OngPolicy < ApplicationPolicy
  def index?
    @user.present? && (@record == @user.ong)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
