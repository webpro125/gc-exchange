class CellPhoneNumberInput < SimpleForm::Inputs::Base
  def input
    ActiveSupport::SafeBuffer.new.tap do |out|
        out << @builder.input(:cell_area_code, wrapper: :phone_input, required: false, placeholder: '000',
                      wrapper_html: { class: 'icon-phone grid-3-12' }, input_html: { maxlength: 3, class: 'cell_area_code'})
        out << "<span class='grid-1-24 type-sep no-break'>-</span>".html_safe
        out << @builder.input(:cell_prefix, wrapper: :phone_input, required: false, placeholder: '000',
                    wrapper_html: { class: 'grid-2-12' }, input_html: { maxlength: 3, class: 'cell_prefix'})
        out << "<span class='grid-1-24 type-sep no-break'>-</span>".html_safe
        out << @builder.input(:cell_line, wrapper: :phone_input, required: false, placeholder: '0000',
                    wrapper_html: { class: 'grid-2-12' }, input_html: { maxlength: 4, class: 'cell_line'})
        out << "<input type='text' name='tmp_cell_phone_number' id='tmp_cell_phone_number' class='hide'>".html_safe
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
