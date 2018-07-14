$(function () {
  var errors = $('.alert.alert-danger');
  var login_error = $('#login-error');
  var sign_up_error = $('#sign-up-error');
  var login_form = $('#log-in-form');
  var sign_up_form = $('#sign-up-form');
  var login_form_btn = $('#log-in-form-btn');
  var sign_up_form_btns = $('.sign-up-form-btn');
  var login_sign_up_modal = $('#login_sign_up_modal');
  if (login_form.length > 0) {
    // Reset forms
    function reset_forms_and_open() {
      login_form.trigger("reset");
      errors.html('');
      errors.hide();
      login_sign_up_modal.modal('show');
      $("#user_role_candidate").attr('checked', true);
      set_signup_fields();
    }
    // Set signup fields
    function set_signup_fields() {
      if ($("#user_role_candidate").prop('checked')) {
        $('.client-fields').hide();
        $('.candidate-fields').show();
      } else {
        $('.client-fields').show();
        $('.candidate-fields').hide();
      }
    }
    // Login Validate
    login_form.validate({
      errorClass: 'is-invalid',
      rules: {
        'user[email]': {
          required: true,
          email: true
        },
        'user[password]': {
          required: true,
          minlength: 6,
          maxlength: 64
        }
      },
      submitHandler: function (form) {
        login_error.html('');
        login_error.hide();
        var formData = $(form).serialize();
        $.ajax({
          type: 'POST',
          beforeSend: function (xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
          },
          url: $(form).attr('action'),
          data: formData,
          success: function (response) {
            window.location.href = response.location;
          },
          error: function (response) {
            login_error.show();
            login_error.html(response.responseText);
          }
        });
      }
    });
    // Login button click
    login_form_btn.click(function () {
      reset_forms_and_open();
      $('#login_sign_up_tabs a[href="#login"]').tab('show')
    });
    /*$(login_form).submit(function (event) {
     // Stop the browser from submitting the form.
     if(login_form.valid()){
     event.preventDefault();
     
     }
     });*/


    // Signup button click
    sign_up_form_btns.click(function () {
      reset_forms_and_open();
      $('#login_sign_up_tabs a[href="#sign_up"]').tab('show')
    });

    $('.ssign-uup-bbtn').click(function () {
      // Validate Signup form
      sign_up_form.validate({
        errorClass: 'is-invalid',
        rules: {
          'user[first_name]': {
            required: true
          },
          'user[last_name]': {
            required: true
          },
          'user[current_location]': {
            required: {
              depends: function (element) {
                return $("#user_role_candidate").prop('checked')
              }
            }
          },
          'user[salary_expectation]': {
            required: {
              depends: function (element) {
                return $("#user_role_candidate").prop('checked')
              }
            }
          },
          'user[email]': {
            required: true,
            email: true
          },
          'user[password]': {
            required: true,
            minlength: 6,
            maxlength: 64
          },
          'user[password_confirmation]': {
            required: true,
            minlength: 6,
            maxlength: 64,
            equalTo: "#sign_up_password"
          }
        }
      });
      if ($(sign_up_form).valid())
        $(sign_up_form).submit();
    });

    // Reset fields
    $("#user_role_candidate, #user_role_client").click(function () {
      set_signup_fields();
    })
    /*$(sign_up_form).submit(function (event) {
     // Stop the browser from submitting the form.
     event.preventDefault();
     login_error.html('');
     login_error.hide();
     var formData = $(sign_up_form).serialize();
     $.ajax({
     type: 'POST',
     beforeSend: function (xhr) {
     xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
     },
     url: $(sign_up_form).attr('action'),
     data: formData,
     success: function (response) {
     
     },
     error: function (response) {
     login_error.show();
     login_error.html(response.responseText);
     }
     });
     })*/
  }
});