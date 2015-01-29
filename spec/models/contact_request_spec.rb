require 'spec_helper'

describe ContactRequest do
  let!(:consultant) { FactoryGirl.create(:confirmed_consultant, :approved) }
  let!(:company) { FactoryGirl.create(:company, :with_owner) }

  subject do
    ContactRequest.new(
      consultant: consultant,
      company: company,
      project_start: 1.month.ago,
      project_end: 2.months.from_now
    )
  end

  it { should be_valid }

  describe 'association' do
    describe 'consultant' do
      before do
        subject.save!
      end

      it 'should not be destroyed on delete' do
        consultant_id = subject.consultant_id

        subject.destroy
        expect(Consultant.find_by_id(consultant_id)).not_to be_nil
      end
    end

    describe 'company' do
      before do
        subject.save!
      end

      it 'should not be destroyed on delete' do
        company_id = subject.company_id

        subject.destroy
        expect(Company.find_by_id(company_id)).not_to be_nil
      end
    end
  end
end
