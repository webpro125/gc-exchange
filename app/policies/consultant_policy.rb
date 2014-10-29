class ConsultantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.pending_approval
    end
  end

  def approve?
    user.present? && user.gces?
  end

  alias_method :reject?, :approve?
  alias_method :index?, :approve?

  def show?
    approve? || (record.approved? || record.pending_approval?)
  end
end
