$(document).ready(function () {
   $('form#login_form').validate({
       errorClass: 'form-validation message error no-padding',
       errorElement: 'small',
       errorPlacement: function(error, e) {
           e.parents('fieldset').append(error);
       },
       highlight: function(e) {
           $(e).closest('fieldset').removeClass('invalid').addClass('invalid');
           $(e).closest('.form-validation').remove();
       },
       success: function(e) {
           e.closest('fieldset').removeClass('invalid');
           e.closest('.form-validation').remove();
       },
       rules: {
           'user[email]': {
               required: true,
               email: true,
               maxlength: 128
           },
           'user[password]': {
               required: true,
               maxlength: 128
           }
       },
       messages: {
           'user[email]': {
               required: "Can't be blank"
           },
           'user[password]': {
               required: "Can't be blank"
           }
       }
   });
});
$('button.login-button').on('click', function(e) {
    e.preventDefault();
    form_obj = $('form#login_form');
    if (form_obj.valid()) {
        form_obj.submit();
    } else return false;
});