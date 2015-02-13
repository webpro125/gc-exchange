require 'spec_helper'

describe ContactRequestSetStatus do
  subject { ContactRequestSetStatus.new contact_request }

  let!(:consultant) { FactoryGirl.create(:confirmed_consultant, :approved) }
  let!(:user) { FactoryGirl.create(:user, :with_company) }
  let!(:contact_request) { FactoryGirl.create(:contact_request) }

  describe 'status is pending' do

    describe 'interested_and_save' do
      it 'returns true' do
        expect(subject.interested_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(ContactRequest).to receive(:save)
        subject.interested_and_save
      end

      it 'sets interested_status' do
        subject.interested_and_save
        expect(contact_request.interested?).to eq true
      end
    end

    describe 'not_interested_and_save' do
      it 'returns true' do
        expect(subject.not_interested_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(ContactRequest).to receive(:save)
        subject.not_interested_and_save
      end

      it 'sets not_interested_status' do
        subject.not_interested_and_save
        expect(contact_request.not_interested?).to eq true
      end
    end
  end

  describe 'status is interested' do
    before do
      subject.interested_and_save
    end

    describe 'hire_and_save' do
      it 'returns true' do
        expect(subject.hire_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(ContactRequest).to receive(:save)
        subject.hire_and_save
      end

      it 'sets hired_status' do
        subject.hire_and_save
        expect(contact_request.hired?).to eq true
      end
    end

    describe 'not_pursuing_and_save' do
      it 'returns true' do
        expect(subject.not_pursuing_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(ContactRequest).to receive(:save)
        subject.not_pursuing_and_save
      end

      it 'sets hired_status' do
        subject.not_pursuing_and_save
        expect(contact_request.not_pursuing?).to eq true
      end
    end

    describe 'not_interested_and_save' do
      it 'returns true' do
        expect(subject.not_interested_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(ContactRequest).to receive(:save)
        subject.not_interested_and_save
      end

      it 'sets not_interested_status' do
        subject.not_interested_and_save
        expect(contact_request.not_interested?).to eq true
      end
    end
  end

  describe 'status is hired' do
    before do
      subject.interested_and_save
      subject.hire_and_save
    end

    describe 'agree_to_terms_and_save' do
      it 'returns true' do
        expect(subject.agree_to_terms_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(ContactRequest).to receive(:save)
        subject.agree_to_terms_and_save
      end

      it 'sets hired_agreed_to_terms_status' do
        subject.agree_to_terms_and_save
        expect(contact_request.agreed_to_terms?).to eq true
      end
    end

    describe 'reject_terms_and_save' do
      it 'returns true' do
        expect(subject.reject_terms_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(ContactRequest).to receive(:save)
        subject.reject_terms_and_save
      end

      it 'sets rejected_terms_status' do
        subject.reject_terms_and_save
        expect(contact_request.rejected_terms?).to eq true
      end
    end

    describe 'not_interested_and_save' do
      it 'returns true' do
        expect(subject.not_interested_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(ContactRequest).to receive(:save)
        subject.not_interested_and_save
      end

      it 'sets not_interested_status' do
        subject.not_interested_and_save
        expect(contact_request.not_interested?).to eq true
      end
    end
  end

  describe 'status is rejected terms' do
    before do
      subject.interested_and_save
      subject.hire_and_save
      subject.reject_terms_and_save
    end

    describe 'hire_and_save' do
      it 'returns true' do
        expect(subject.hire_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(ContactRequest).to receive(:save)
        subject.hire_and_save
      end

      it 'sets hired_status' do
        subject.hire_and_save
        expect(contact_request.hired?).to eq true
      end
    end
  end
end
