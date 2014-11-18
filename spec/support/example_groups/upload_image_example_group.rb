shared_examples 'upload_image' do
  describe 'profile_image' do
    it { should respond_to(:profile_image) }
  end
end
