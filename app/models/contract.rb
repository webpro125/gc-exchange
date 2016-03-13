class Contract
  attr_reader :user, :consultant, :entity
  attr_accessor :updating_contract

  def self.for_consultant(user)
    consultant = user.consultant
    if consultant.entity.sole_proprietor?
      Contract::SoleProprietor.new(user)
    else
      Contract::BusinessEntity.new(user)
    end
  end


  def initialize(user)
    @user = user
    consultant = user.consultant
    @consultant = consultant
    @entity = consultant.entity
  end

  def sole_proprietor?
    entity.sole_proprietor?
  end

  def full_name
    user.full_name
  end

  def phone
    user.consultant.phones.first.number_with_ext
  end

  def effective_date
    if updating_contract.present? || user.consultant.contract_effective_date.blank?
      DateTime.now.to_formatted_s(:month_day_and_year)
    else
      user.consultant.contract_effective_date.to_formatted_s(:month_day_and_year)
    end
  end

  class BusinessEntity < Contract
    def address
      entity.full_address
    end

    def title
      entity.title
    end

    def legal_name
      entity.name
    end

    def full_name_and_legal_name
      "#{user.full_name} of #{legal_name}, a #{entity.entity_label}"
    end
  end

  class SoleProprietor < Contract
    def address
      user.consultant.street_address
    end

    def title
      "Consultant"
    end

    def legal_name
      user.full_name
    end

    def full_name_and_legal_name
      "#{legal_name} an #{entity.entity_label}"
    end
  end
end
