class AddSmsNotificationToConsultants < ActiveRecord::Migration
  def change
    add_column :consultants, :sms_notification, :boolean, default: true
  end
end
