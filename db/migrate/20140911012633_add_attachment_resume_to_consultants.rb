class AddAttachmentResumeToConsultants < ActiveRecord::Migration
  def change
    change_table :consultants do |t|
      t.attachment :resume
    end
  end
end
