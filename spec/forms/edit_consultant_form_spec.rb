require 'spec_helper'

describe EditConsultantForm do
  it_behaves_like 'qualifications'

  let(:mime_types) do
    [
      'application/msword',
      'application/vnd.ms-word',
      'applicaiton/vnd.openxmlformats-officedocument.wordprocessingm1.document',
      'application/pdf'
    ]
  end

  let(:reject) do
    ['text/plain', 'text/xml']
  end

  let(:consultant) do
    Consultant.new(
      first_name: 'Freddy',
      last_name: 'Kreuger',
      rate: 100,
      address: FactoryGirl.build(:address),
      military: FactoryGirl.build(:military),
      phones: FactoryGirl.build_list(:phone, 2),
      educations: FactoryGirl.build_list(:education, 2)
    )
  end
  let(:form) { EditConsultantForm.new(consultant) }
  subject { form }

  it { should be_valid }

  describe 'consultant' do
    describe 'first_name' do
      it { should ensure_length_of(:first_name).is_at_least(2).is_at_most(24) }
      it { should validate_presence_of(:first_name) }
      it { should allow_value('james', 'mary ann', 'Robert').for(:first_name) }

      it { should_not allow_value('billy-jean 2', '1234567890', '!@#$%').for(:first_name) }
    end

    describe 'last_name' do
      it { should ensure_length_of(:last_name).is_at_least(2).is_at_most(24) }
      it { should validate_presence_of(:last_name) }
      it { should allow_value('james', 'mary ann', 'billy-jean 2', '1234567890').for(:last_name) }

      it { should_not allow_value('!@#$%').for(:last_name) }
    end

    describe 'rate' do
      it { should validate_presence_of(:rate) }
      it { should validate_numericality_of(:rate).is_greater_than(0) }
    end

    describe 'willing_to_travel' do
      it { should validate_presence_of(:willing_to_travel) }
    end
  end

  describe 'address' do
    subject do
      form.address
    end

    it { should validate_presence_of(:address) }
    it { should ensure_length_of(:address).is_at_least(3).is_at_most(512) }
  end

  describe 'phone' do
    subject do
      form.phones.first
    end

    describe 'number' do
      it { should validate_presence_of(:number) }
    end

    describe 'phone_type_id' do
      it { should validate_presence_of(:phone_type_id) }
    end
  end

  describe 'military' do
    subject do
      form.military
    end

    describe 'service_end_date' do
      it 'should not be greater than today' do
        subject.service_end_date = 3.day.from_now
        expect(subject).not_to be_valid
      end

      it 'should not be less than start_date' do
        subject.service_end_date = 3.years.ago
        expect(subject).not_to be_valid
      end
    end

    describe 'branch' do
      describe 'rank is present' do
        before do
          subject.rank_id = Rank.first.id
        end

        it { should validate_presence_of(:branch_id) }
      end

      describe 'rank is not present' do
        before do
          subject.rank_id = nil
        end

        it { should_not validate_presence_of(:branch_id) }
      end
    end

    describe 'rank' do
      describe 'branch is present' do
        before do
          subject.branch_id = Branch.first.id
        end

        it { should validate_presence_of(:rank_id) }
      end

      describe 'branch is not present' do
        before do
          subject.branch_id = nil
        end

        it { should_not validate_presence_of(:rank_id) }
      end
    end
  end
end
