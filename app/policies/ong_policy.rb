class OngPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true  # Permitir acesso à lista de ONGs para todos os usuários autenticados
  end

  def show?
    true  # Permitir acesso a uma ONG específica para todos os usuários autenticados
  end

  def create?
    @user.present? # Permitir a criação de uma ONG apenas se o usuário estiver autenticado
  end

  def update?
    @user.present? && (@record.user == @user)  # Permitir a atualização apenas se o usuário for o proprietário da ONG
  end

  def destroy?
    @user.present? && (@record.user == @user)  # Permitir a exclusão apenas se o usuário for o proprietário da ONG
  end

  class Scope < Scope
    def resolve
      scope.all # Permitir que todos os usuários autenticados vejam todas as ONGs
    end
  end
end
