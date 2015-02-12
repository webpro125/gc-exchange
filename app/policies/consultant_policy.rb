class ConsultantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.approve_reject
    end
  end

  def approve?
    gces? && ConsultantSetStatus.new(record).approvable?
  end

  def reject?
    gces? && ConsultantSetStatus.new(record).rejectable?
  end

  def index?
    gces?
  end

  def show?
    edit? || record.approved? || record.pending_approval?
  end

  def edit?
    gces? || user == record
  end

  alias_method :update?, :edit?

  def upload_resume?
    user == record || gces?
  end

  alias_method :upload_image?, :upload_resume?
  alias_method :consultant?, :upload_resume?

  private

  def gces?
    user.present? && user.respond_to?(:gces?) && user.gces?
  end
end
