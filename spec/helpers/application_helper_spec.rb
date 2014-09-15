require 'spec_helper'

describe ApplicationHelper do

  describe '#development?' do
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

  describe '#build_simple_form_dropdown' do
    let(:klass) { PhoneType }

    describe 'return hash' do
      it 'returns ":id" for value_method' do
        expect(build_simple_form_dropdown(klass)[:value_method]).to eq(:id)
      end

      it 'contains "label_method"' do
        expect(build_simple_form_dropdown(klass)[:label_method]).to be_a(Proc)
      end
    end
  end
end
