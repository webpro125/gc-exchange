shared_examples 'basic_information' do
  describe 'consultant' do
    describe 'abstract' do
      it { should validate_presence_of(:abstract) }
      it { should ensure_length_of(:abstract).is_at_least(2).is_at_most(1500) }
    end
  end
end
