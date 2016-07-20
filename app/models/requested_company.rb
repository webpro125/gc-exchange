class RequestedCompany < ActiveRecord::Base

  belongs_to :user
  attr_accessor :work_area_code, :work_prefix, :work_line
  attr_accessor :cell_area_code, :cell_prefix, :cell_line
  before_save :store_phone

  validates :company_name, length: { in: 2..512 }, presence: true
  validates :work_area_code, :work_prefix,
            length: { is: 3 }, presence: true,  :numericality => true
  validates :cell_area_code, :cell_prefix,
            length: { is: 3 }, allow_blank: true,  :numericality => true
  validates :work_line, length: { is: 4 }, presence: true,  :numericality => true
  validates :cell_line, length: { is: 4 }, allow_blank: true,  :numericality => true
  validates :help_content, presence: true, length: { in: 2..500 }

  def created_email user
    email_text = '
      {user_full_name}, thank you for your request to register {company_name}.
      A GCES Representative will be contacting you shortly to help you complete the registration process.'
    email_text.gsub!("{user_full_name}", user.full_name)
    email_text.gsub!("{company_name}", self.company_name)
    email_text
  end


  private

  def store_phone
    unless @work_area_code.blank? && @work_prefix.blank? && @work_line.blank?
      self.work_phone = "#{@work_area_code}-#{@work_prefix}-#{@work_line}"
    end
    if @cell_area_code.blank? && @cell_prefix.blank? && @cell_line.blank?
      self.cell_phone = ''
    else
      self.cell_phone = "#{@cell_area_code}-#{@cell_prefix}-#{@cell_line}"
    end
  end

end
