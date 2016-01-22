class Contract
  attr_reader :consultant, :entity
  attr_accessor :updating_contract

  def self.for_consultant(consultant)
    if consultant.entity.sole_proprietor?
      Contract::SoleProprietor.new(consultant)
    else
      Contract::BusinessEntity.new(consultant)
    end
  end


  def initialize(consultant)
    @consultant = consultant
    @entity = consultant.entity
  end

  def sole_proprietor?
    entity.sole_proprietor?
  end

  def full_name
    consultant.full_name
  end

  def phone
    consultant.phones.first.number_with_ext
  end

  def effective_date
    if updating_contract.present? || consultant.contract_effective_date.blank?
      DateTime.now.to_formatted_s(:month_day_and_year)
    else
      consultant.contract_effective_date.to_formatted_s(:month_day_and_year)
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
      "#{consultant.full_name} of #{legal_name}, a #{entity.entity_label}"
    end
  end

  class SoleProprietor < Contract
    def address
      consultant.street_address
    end

    def title
      "Consultant"
    end

    def legal_name
      consultant.full_name
    end

    def full_name_and_legal_name
      "#{legal_name} an #{entity.entity_label}"
    end
  end
end
