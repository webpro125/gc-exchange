require 'spec_helper'

describe Contract do

  let(:consultant){ build(:consultant,
                          entity: build(:entity, entity_type: 'sole_proprietor'),
                          address: build(:address)) }

  subject { Contract.for_consultant(consultant) }

  describe "#effective_date" do
    let(:today){ DateTime.now.to_formatted_s(:month_day_and_year) }

    it 'returns now when a new contract is being signed' do
      expect(subject.effective_date).to eq today
    end
    it 'returns now when a contract is being updated' do
      consultant.contract_effective_date = DateTime.now - 2.days
      subject.updating_contract = true
      expect(subject.effective_date).to eq today
    end
    it 'returns the effective date when being viewed in a pdf' do
      date = consultant.contract_effective_date = DateTime.now - 2.days
      expect(subject.effective_date).to eq date.to_formatted_s(:month_day_and_year)
    end
  end

  context 'when sole proprietor' do
    let(:consultant){ build(:consultant,
                            entity: build(:entity, entity_type: 'sole_proprietor'),
                            address: build(:address)) }

    subject { Contract.for_consultant(consultant) }

    describe "#address" do
      it 'uses the consultants home address' do
        expect(subject.address).to eq consultant.street_address
      end
    end

    describe "#title" do
      it 'returns Consultant' do
        expect(subject.title).to eq "Consultant"
      end
    end

    describe "#legal_name" do
      it 'returns consultant name' do
        expect(subject.legal_name).to eq consultant.full_name
      end
    end
  end

  context 'when a corp or other business entity' do
    let(:consultant){ build(:consultant,
                            entity: build(:entity, entity_type: 's_corp'),
                            address: build(:address)) }

    subject { Contract.for_consultant(consultant) }

    describe "#address" do
      it 'uses the entity address' do
        expect(subject.address).to eq consultant.entity.full_address
      end
    end

    describe "#title" do
      it 'returns entity title' do
        expect(subject.title).to eq consultant.entity.title
      end
    end

    describe "#legal_name" do
      it 'returns entity name' do
        expect(subject.legal_name).to eq consultant.entity.name
      end
    end
  end

end
