require 'spec_helper'

describe ApplicationHelper do

  describe 'development?' do
    it 'should return true in development' do
      Rails.env.stub(:development?) { true }
      expect(development?).to be true
    end

    it 'should return false in test' do
      expect(development?).to be false
    end

    it 'should return false in production' do
      expect(development?).to be false
    end
  end
end
