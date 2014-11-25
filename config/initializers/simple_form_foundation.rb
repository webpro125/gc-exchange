# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.wrappers :foundation, class: :input, hint_class: :field_with_hint,
                  error_class: :error do |b|
    b.use :html5
    b.use :placeholder
    b.use :maxlength
    b.use :pattern
    b.use :min_max
    b.optional :readonly
    b.wrapper tag: :div do |ba|
      ba.use :label_input
      ba.use :error, wrap_with: { tag: :small, class: :error }

      # Uncomment the following line to enable hints.
      # The line is commented out by default since Foundation does't provide styles for hints. You
      # will need to provide your own CSS styles for hints.
      ba.use :hint,  wrap_with: { tag: :p, class: [:hint] }
    end
  end

  # CSS class for buttons
  config.button_class = 'button small'

  # CSS class to add for error notification helper.
  config.error_notification_class = 'alert-box alert'

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :foundation
end
