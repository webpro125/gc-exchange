module ApplicationHelper
  LOOKUPS = [PhoneType].freeze

  # Determines if we're in a development type environment
  #
  # Returns true for following environments
  # - development
  #
  # Returns false for the following environments
  # - test
  # - production
  def development?
    return Rails.env.development?
  end

  # Looks up a translation for a Lookup
  #
  # Returns a translation
  # Params:
  # +klass+:: the class of lookup we're looking up.  Valid values are part of +Lookup::LOOKUPS+
  # +value+:: the value of the lookup.  Valid values are in +Lookup::#{Type}+
  def lookup_translation(klass, value)
    raise 'Invalid class.  Please use Lookup::LOOKUPS' unless LOOKUPS.include? klass
    I18n.t("simple_form.options.#{klass.to_s.underscore}.#{value.underscore}")
  end

  # Generates the translation options for simple_form for associations
  # The label proc is generated to return the translations for the dropdown
  #
  # Params
  # - klass
  #   - The class of the dropdown to Lookup
  #
  # Returns a hash { value_method: :id, label_method: label }
  #
  def build_simple_form_dropdown(klass)
    label = ->(type) { lookup_translation(klass, type.code) }

    { value_method: :id, label_method: label }
  end
end
