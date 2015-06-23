class ConsultantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
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

  def contract?
    record.contract_effective_date.present? && (gces? || user == record)
  end

  def contactable?
    user == record
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
