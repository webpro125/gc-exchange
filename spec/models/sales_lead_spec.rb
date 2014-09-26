require 'spec_helper'

describe SalesLead do
  before do
    @sales_lead = SalesLead.new(
        first_name: 'FirstName',
        last_name: 'LastName',
        company_name: 'Company Name',
        message: 'I am really interested in joining this awesome site!',
        email: 'test@test.com',
        phone_number: '123-123-1321'
    )
  end

  subject { @sales_lead }

  it { should be_valid }

  describe 'first_name' do
    it 'should have a minimum length' do
      @sales_lead.first_name = 'a' * 1
      expect(@sales_lead).not_to be_valid
    end

    it 'should have a maximum length' do
      @sales_lead.first_name = 'a' * 25
      expect(@sales_lead).not_to be_valid
    end

    it 'should be present' do
      @sales_lead.first_name = nil
      expect(@sales_lead).not_to be_valid
    end
  end

  describe 'last_name' do
    it 'should have a minimum length' do
      @sales_lead.last_name = 'a' * 1
      expect(@sales_lead).not_to be_valid
    end

    it 'should have a maximum length' do
      @sales_lead.last_name = 'a' * 25
      expect(@sales_lead).not_to be_valid
    end

    it 'should be present' do
      @sales_lead.last_name = nil
      expect(@sales_lead).not_to be_valid
    end
  end

  describe 'company_name' do
    it 'should have a minimum length' do
      @sales_lead.company_name = 'a' * 1
      expect(@sales_lead).not_to be_valid
    end

    it 'should have a maximum length' do
      @sales_lead.company_name = 'a' * 129
      expect(@sales_lead).not_to be_valid
    end

    it 'should be present' do
      @sales_lead.company_name = nil
      expect(@sales_lead).not_to be_valid
    end
  end

  describe 'message' do
    it 'should have a minimum length' do
      @sales_lead.message = 'a' * 1
      expect(@sales_lead).not_to be_valid
    end

    it 'should have a maximum length' do
      @sales_lead.message = 'a' * 10_001
      expect(@sales_lead).not_to be_valid
    end

    it 'should be present' do
      @sales_lead.message = nil
      expect(@sales_lead).not_to be_valid
    end
  end

  describe 'email' do
    it 'should be present' do
      @sales_lead.email = nil
      expect(@sales_lead).not_to be_valid
    end
  end

  describe 'phone_number' do
    it 'should be present' do
      @sales_lead.phone_number = nil
      expect(@sales_lead).not_to be_valid
    end
  end
end
