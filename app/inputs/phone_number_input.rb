class PhoneNumberInput < SimpleForm::Inputs::Base
  def input
    ActiveSupport::SafeBuffer.new.tap do |out|
        out << @builder.input(:area_code, wrapper: :phone_input, required: false, placeholder: '000', wrapper_html: { class: 'icon-phone' })
        out << "<span class='grid-1-24 type-sep no-break'>-</span>".html_safe
        out << @builder.input(:prefix, wrapper: :phone_input, required: false, placeholder: '000')
        out << "<span class='grid-1-24 type-sep no-break'>-</span>".html_safe
        out << @builder.input(:line, wrapper: :phone_input, required: false, placeholder: '0000')
    end
    # ActiveSupport::SafeBuffer.new.tap do |out|
    #   @builder.simple_fields_for attribute_name, number do |ff|
    #     out << ff.input(:area_code, wrapper: :phone_input, required: false)
    #     out << ff.input(:prefix, wrapper: :phone_input, required: false)
    #     out << ff.input(:line, wrapper: :phone_input, required: false)
    #   end
    # end
  end
  def number
    object.send(attribute_name)
  end
end
