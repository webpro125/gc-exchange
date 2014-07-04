require 'spec_helper'
require 'lookup'

describe Lookup do
  describe '#lookup_translation' do
    it 'should raise error with invalid class' do
      expect { Lookup.lookup_translation(Object, 'value') }.to raise_exception
    end

    it 'should return translation' do
      type = PhoneType
      value = PhoneType::CELL

      expect(Lookup.lookup_translation(type,value)).to eq(I18n.t("lookup.#{PhoneType.to_s
                                                                .underscore}.#{value.underscore}"))
    end
  end
end
