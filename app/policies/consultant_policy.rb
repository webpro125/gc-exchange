class ConsultantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.pending_approval
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
    edit? || record.approved?
  end

  def edit?
    gces? || user == record
  end

  alias_method :update?, :edit?

  def upload?
    user == record
  end

  def download?
    gces? || user.present? && user == record || user.present? && record.approved?
  end

  alias_method :upload_image?, :upload?
  alias_method :resume?, :upload?
  alias_method :upload_resume?, :upload?
  alias_method :consultant?, :upload?

  private

  def gces?
    user.present? && user.respond_to?(:gces?) && user.gces?
  end
end
