$( function() {
  $('.add_fields').click(function(e) { 
    e.preventDefault();

    old_id = new RegExp($(this).data('id'), 'g');
    time = new Date().getTime();
    new_fields = $(this).data('fields').replace(old_id, time)

    $('.row').append(new_fields);
    $('.remove_fields:last').click(remove_fields_func)
  })

  $('.remove_fields').click(remove_fields_func);
})

var remove_fields_func = function(e) {
  e.preventDefault();

  $(this).prev('input').val(1);
  $(this).parents('.col-md-4').hide();
}