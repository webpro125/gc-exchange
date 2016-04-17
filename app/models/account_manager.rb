class AccountManager < ActiveRecord::Base
  include Nameable

  belongs_to :user
  belongs_to :company
end
