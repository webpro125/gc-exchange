class ConsultantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(wizard_step: Wicked::FINISH_STEP)
    end
  end

  def approve?
    gces? && ConsultantSetStatus.new(record).approvable?
  end

  def reject?
    gces? && ConsultantSetStatus.new(record).rejectable?
  end

  def index?
    true
    # user.owned_company.present?
  end

  def show?
    # edit? || record.approved?
    true
  end

  def edit?
    gces? || (user.consultant == record && user.consultant.wizard_step == Wicked::FINISH_STEP)
    # gces? || user == record
  end

  def contract?
    record.contract_effective_date.present? && (gces? || user.consultant == record)
  end

  def contactable?
    user == record
  end

  alias_method :update?, :edit?

  def upload_resume?
    # user.consultant == record || gces?
    gces? || (user.consultant == record && user.consultant.wizard_step == Wicked::FINISH_STEP)
  end

  alias_method :upload_image?, :upload_resume?
  alias_method :consultant?, :upload_resume?
  alias_method :update_sms_notification?, :upload_resume?

  private

  def gces?
    user.present? && user.respond_to?(:gces?) && user.gces?
  end
end
