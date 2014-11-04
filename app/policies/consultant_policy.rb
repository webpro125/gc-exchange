class ConsultantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.pending_approval
    end
  end

  def approve?
    user.present? && user.respond_to?(:gces?) && user.gces?
  end

  alias_method :reject?, :approve?
  alias_method :index?, :approve?

  def show?
    edit? || (record.approved? || record.pending_approval?)
  end

  def edit?
    approve? || user == record
  end

  alias_method :update?, :edit?
end
