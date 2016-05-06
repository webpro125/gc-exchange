class RequestedCompany < ActiveRecord::Base

  belongs_to :user
  attr_accessor :work_area_code, :work_prefix, :work_line
  attr_accessor :cell_area_code, :cell_prefix, :cell_line
  before_save :store_phone

  validates :company_name, length: { in: 2..512 }, presence: true
  validates :work_area_code, :work_prefix, :cell_area_code, :cell_prefix,
            length: { is: 3 }, presence: true,  :numericality => true
  validates :work_line, :cell_line, length: { is: 4 }, presence: true,  :numericality => true
  validates :help_content, presence: true, length: { in: 2..500 }
=begin
  validates :work_phone,
            presence: true,
            format:   {
                with:    RegexConstants::Phone::PHONE_NUMBER,
                message: I18n.t('activerecord.errors.messages.regex.phone')
            }
=end

  private

  def store_phone
    unless @work_area_code.blank? && @work_prefix.blank? && @work_line.blank?
      self.work_phone = "#{@work_area_code}-#{@work_prefix}-#{@work_line}"
    end
    unless @cell_area_code.blank? && @cell_prefix.blank? && @cell_line.blank?
      self.cell_phone = "#{@cell_area_code}-#{@cell_prefix}-#{@cell_line}"
    end
  end

end
