require 'spec_helper'

describe Discipline do
  before do
    @discipline = Discipline.new(code: 'OTHER')
  end

  subject { @discipline }

  it { should be_valid }

  describe 'code' do
    it 'should have a max length' do
      @discipline.code = 'a' * 33
      expect(@discipline).to_not be_valid
    end

    it 'should be unique' do
      @discipline.save
      discipline = @discipline.dup
      expect(discipline).to_not be_valid
    end
  end
end
