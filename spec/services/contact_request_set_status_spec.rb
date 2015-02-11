require 'spec_helper'

describe ContactRequestSetStatus do
  subject { ContactRequestSetStatus.new contact_request }

  let!(:consultant) { FactoryGirl.create(:confirmed_consultant, :approved) }
  let!(:user) { FactoryGirl.create(:user, :with_company) }
  let!(:contact_request) { FactoryGirl.create(:contact_request) }

  describe 'status is pending' do

    describe 'approve_and_save' do
      it 'returns true' do
        expect(subject.approve_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(ContactRequest).to receive(:save)
        subject.approve_and_save
      end

      it 'sets approved_status' do
        subject.approve_and_save
        expect(contact_request.approved?).to eq true
      end
    end

    describe 'reject_and_save' do
      it 'returns true' do
        expect(subject.reject_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(ContactRequest).to receive(:save)
        subject.reject_and_save
      end

      it 'sets approved_status' do
        subject.reject_and_save
        expect(contact_request.rejected?).to eq true
      end
    end
  end

  describe 'status is approved' do
    before do
      subject.approve_and_save
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

    describe 'fire_and_save' do
      it 'returns true' do
        expect(subject.fire_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(ContactRequest).to receive(:save)
        subject.fire_and_save
      end

      it 'sets hired_status' do
        subject.fire_and_save
        expect(contact_request.fired?).to eq true
      end
    end
  end

  describe 'status is hired' do
    before do
      subject.approve_and_save
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

      it 'sets hired_status' do
        subject.agree_to_terms_and_save
        expect(contact_request.agreed_to_terms?).to eq true
      end

      describe 'reject_terms_and_save' do
        it 'returns true' do
          expect(subject.reject_terms_and_save).to eq true
        end

        it 'calls save' do
          expect_any_instance_of(ContactRequest).to receive(:save)
          subject.reject_terms_and_save
        end

        it 'sets hired_status' do
          subject.reject_terms_and_save
          expect(contact_request.rejected_terms?).to eq true
        end
      end
    end
  end
end
