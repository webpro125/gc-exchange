class PhoneUnsetPrimaries
  def initialize(phone)
    @phone = phone
  end

  def save
    return false unless @phone.valid?

    ActiveRecord::Base.transaction do
      @phone.save!
      if @phone.primary
        @phone.phoneable.phones.where.not(id: @phone.id).update_all(primary: false)
      end
    end
    true
  end
end
