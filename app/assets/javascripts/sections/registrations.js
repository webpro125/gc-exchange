$(document).ready(function () {
   $('form#registration_form').validate({
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
           'user[first_name]': {
               required: true,
               alphanumeric: true,
               maxlength: 24
           },
           'user[last_name]': {
               required: true,
               alphanumeric: true,
               maxlength: 24
           },
           'user[password]': {
               required: true,
               minlength: 8,
               maxlength: 128
           },
           'user[password_confirmation]': {
               required: true,
               minlength: 8,
               maxlength: 128,
               equalTo: "#user_password"
           }
       },
       messages: {
           'user[email]': {
               required: "Can't be blank"
           },
           'user[first_name]': {
               required: "Can't be blank"
           },
           'user[last_name]': {
               required: "Can't be blank"
           },
           'user[password]': {
               required: "Can't be blank"
           },
           'user[password_confirmation]': {
               required:  "Can't be blank",
               equalTo: "#user_password"
           }
       }
   });
});
$('button.register-button').on('click', function(e) {
    e.preventDefault();
    form_obj = $('form#registration_form');
    if (form_obj.valid()) {
        form_obj.submit();
    } else return false;
});