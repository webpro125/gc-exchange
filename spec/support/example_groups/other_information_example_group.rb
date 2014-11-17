shared_examples 'other_information' do
  describe 'consultant' do
    describe 'rate' do
      it { should validate_presence_of(:rate) }
      it { should validate_numericality_of(:rate).is_greater_than(0) }
    end

    describe 'willing_to_travel' do
      it { should validate_presence_of(:willing_to_travel) }
    end
  end

  describe 'military' do
    describe 'service_end_date' do
      it 'should not be greater than today' do
        subject.military.service_end_date = 3.day.from_now
        expect(subject.military).not_to be_valid
      end

      it 'should not be less than start_date' do
        subject.military.service_end_date = 3.years.ago
        expect(subject.military).not_to be_valid
      end
    end

    describe 'branch' do
      describe 'rank is present' do
        before do
          subject.military.rank_id = Rank.first.id
        end

        it 'validates presence of branch' do
          expect(subject.military).to validate_presence_of(:branch_id)
        end
      end

      describe 'rank is not present' do
        before do
          subject.military.rank_id = nil
        end

        it 'does not validate presence of branch' do
          expect(subject.military).not_to validate_presence_of(:branch_id)
        end
      end
    end

    describe 'rank' do
      describe 'branch is present' do
        before do
          subject.military.branch_id = Branch.first.id
        end

        it 'validates presence of rank' do
          expect(subject.military).to validate_presence_of(:rank_id)
        end
      end

      describe 'branch is not present' do
        before do
          subject.military.branch_id = nil
        end

        it 'does not validate presence of rank' do
          expect(subject.military).not_to validate_presence_of(:rank_id)
        end
      end
    end
  end

  describe 'address' do
    it 'validates presence' do
      expect(subject.address).to validate_presence_of(:address)
    end

    it 'ensures length' do
      expect(subject.address).to ensure_length_of(:address).is_at_least(3).is_at_most(512)
    end
  end

  describe 'phone' do
    describe 'number' do
      it 'should validate presence' do
        expect(subject.phones.first).to validate_presence_of(:number)
      end
    end

    describe 'phone_type_id' do
      it 'should validate presence' do
        expect(subject.phones.first).to validate_presence_of(:phone_type_id)
      end
    end
  end
end
