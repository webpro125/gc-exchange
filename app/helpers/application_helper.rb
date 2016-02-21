module ApplicationHelper
  LOOKUPS = [PhoneType, ClearanceLevel, Branch, Rank, ClearanceLevel, CustomerName, Position,
             ProjectType, State, Certification, ApprovedStatus, Degree, TravelAuthorization].freeze

  # Determines if we're in a development type environment
  #
  # Returns true for following environments
  # - development
  #
  # Returns false for the following environments
  # - test
  # - production
  def development?
    Rails.env.development?
  end

  def body_class(class_name)
    content_for :body_class, class_name
  end

  # Looks up a translation for a Lookup
  #
  # Returns a translation
  # Params:
  # +klass+:: the class of lookup we're looking up.  Valid values are part of +Lookup::LOOKUPS+
  # +value+:: the value of the lookup.  Valid values are in +Lookup::#{Type}+
  def lookup_translation(klass, value)
    fail 'Invalid class.  Please use Lookup::LOOKUPS' unless LOOKUPS.include? klass
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
  def build_simple_form_dropdown(klass, opts = {})
    fail 'Invalid class.  Please use Lookup::LOOKUPS' unless LOOKUPS.include? klass

    label = lambda do |type|
      type.is_a?(String) ? type : type.label
    end

    { label_method: label }.merge(opts)
  end

  def boolean_to_human(boolean)
    boolean ? I18n.t('simple_form.yes') : I18n.t('simple_form.no')
  end

  def date_in_words(start_date, end_date = nil)
    return unless start_date
    distance_of_time_in_words(start_date, end_date || DateTime.now)
  end

  def date_to_formatted_s(date)
    date.try(:to_s, :month_day_and_year)
  end

  def date_options
    { format: :month_day_and_year, as: :date }
  end

  def create_profile_helper(wizard_step)
    wizard_path == create_profile_path(wizard_step) ? 'current' : 'unavailable'
  end
end
