shared_examples 'lookup' do
  describe 'code' do
    it 'should have a max length' do
      expect(subject).to ensure_length_of(:code).is_at_most(32)
    end

    it 'should be unique' do
      expect(subject).to validate_uniqueness_of(:code).case_insensitive
    end

    it 'should be required' do
      expect(subject).to validate_presence_of :code
    end
  end
end
