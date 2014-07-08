require 'lookup'

module ApplicationHelper

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
    label = ->(type) { Lookup.lookup_translation(klass, type.code) }

    { value_method: :id, label_method: label }
  end
end
