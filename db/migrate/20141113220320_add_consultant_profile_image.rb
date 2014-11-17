class AddConsultantProfileImage < ActiveRecord::Migration
  def change
    add_attachment :consultants, :profile_image
  end
end
