class AddCompanyDataToUser < ActiveRecord::Migration
  def change
    User.find_each do |user|
      if user.account_manager.present?
        user.company_id = user.account_manager.company_id
      end
      if user.business_unit_roles.any?
        user.company_id = user.business_unit_roles.first.company.id
      end
      if user.owned_company.present?
        user.company_id = user.owned_company.id
      end
      if user.valid?
        user.save!
      end
    end
  end
end
