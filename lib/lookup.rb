module Lookup
  LOOKUPS = [PhoneType].freeze


  # Looks up a translation for a Lookup
  #
  # Returns a translation
  # Params:
  # +klass+:: the class of lookup we're looking up.  Valid values are part of +Lookup::LOOKUPS+
  # +value+:: the value of the lookup.  Valid values are in +Lookup::#{Type}+
  def self.lookup_translation(klass, value)
    raise 'Invalid class.  Please use Lookup::LOOKUPS' unless LOOKUPS.include? klass
    I18n.t("lookup.#{klass.to_s.underscore}.#{value.underscore}")
  end
end
