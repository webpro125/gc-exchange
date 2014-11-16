class DateTimeInput < SimpleForm::Inputs::DateTimeInput
  def input
    input_html_classes.push 'form-datepicker'
    value = @builder.object.send(attribute_name)
    input_html_options[:value] = case value
                                 when Date, Time, DateTime
                                   format = options[:format] || :medium
                                   value.to_s(format)
                                 else
                                   value.to_s
                                 end

    @builder.text_field(attribute_name, input_html_options)
  end
end
