shared_examples 'lookup' do
  describe 'code' do
    it { should ensure_length_of(:code).is_at_most(32) }
    it { should validate_uniqueness_of(:code).case_insensitive }
    it { should validate_presence_of :code }
  end

  describe 'label' do
    it { should ensure_length_of(:label).is_at_most(256) }
    it { should validate_uniqueness_of(:label).case_insensitive }
    it { should validate_presence_of(:label) }
  end
end
