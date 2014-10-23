class UnsetPrimaries
  def initialize(phone)
    @phone = phone
  end

  def save
    ActiveRecord::Base.transaction do
      save_result = @phone.save
      if @phone.primary
        @phone.phoneable.phones.where.not(id: @phone.id).update_all(primary: false)
      end
      save_result
    end
  end
end
