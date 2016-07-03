ClientSideValidations.formBuilders['SimpleForm::FormBuilder'] = {
    add: function(element, settings, message) {
        if (element.data('valid') !== false) {
            console.log(settings);
            var wrapper = element.closest(settings.wrapper_tag).parent();
            wrapper.parent().addClass(settings.wrapper_error_class);
            var errorElement = $('<' + settings.error_tag + ' class="form-validation message error no-padding">' + message + '</' + settings.error_tag + '>');
            wrapper.append(errorElement);
        } else {
            var wrapper = element.closest(settings.wrapper_tag).parent();
            wrapper.find(settings.error_tag + '.' + settings.error_class).text(message);
        }
    },
    remove: function(element, settings) {
        var wrapper = element.closest(settings.wrapper_tag + '.' + settings.wrapper_error_class).parent();
        console.log(wrapper);
        wrapper.removeClass(settings.wrapper_error_class);
        var errorElement = wrapper.find(settings.error_tag + '.' + settings.error_class);
        errorElement.remove();
    }
};