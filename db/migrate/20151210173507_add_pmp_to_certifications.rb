class AddPmpToCertifications < ActiveRecord::Migration
  def change
    Certification.create(code: 'APMP', label: 'Association of Proposal Management Professionals')
  end
end
