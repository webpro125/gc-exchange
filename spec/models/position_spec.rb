require 'spec_helper'

describe Position do
  before do
    @position = Position.new(code: 'OTHER')
  end

  subject { @position }

  it { should be_valid }

  describe 'code' do
    it 'should have a max length' do
      @position.code = 'a' * 33
      expect(@position).to_not be_valid
    end

    it 'should be unique' do
      @position.save
      position = @position.dup
      expect(position).to_not be_valid
    end
  end
end
