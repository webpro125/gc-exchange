module Contactable
  extend ActiveSupport::Concern

  def contactable(consultant_or_user, unknown)
    if consultant_or_user.class == User
      results = SharedContacts.where(user: consultant_or_user)
      if unknown.class === User
        results[]
        return false
      else
        results.where(consultant: unknown)
        if results.exists?
          return true
        else
          return false
        end
      end
    else
      results = SharedContacts.where(consultant: consultant_or_user)
      if unknown.class == Consultant
        results[]
        return false
      else
        results.where(user: unknown)
        if results.exists?
          return true
        else
          return false
        end
      end
    end
  end
end
