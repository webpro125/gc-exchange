shared_examples 'upload_resume' do
  describe 'resume' do
    it { should respond_to(:resume) }
    it { should validate_presence_of(:resume) }
  end
end
