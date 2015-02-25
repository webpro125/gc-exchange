module Contactable
  extend ActiveSupport::Concern

  def contactable(consultant_or_user)
    if self.class == Consultant && consultant_or_user.class == User
      shared_contacts.exists?(user: consultant_or_user)
    elsif self.class == User && consultant_or_user.class == Consultant
      shared_contacts.exists?(consultant: consultant_or_user)
    else
      fail('Contactable Error')
    end
  end
end
