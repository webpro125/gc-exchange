class AddUserDataToConsultant < ActiveRecord::Migration
  def change
    User.find_each do |user|
      unless user.consultant.present?
        user.build_consultant
        user.save!
      end
    end
  end
end
