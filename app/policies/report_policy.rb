class ReportPolicy < ApplicationPolicy
  def index?
    gces?
  end

  private

  def gces?
    user.present? && user.respond_to?(:gces?) && user.gces?
  end
end
