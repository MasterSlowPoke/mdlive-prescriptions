$( function() {
  $('.add_fields').click(function(e) { 
    e.preventDefault();

    old_id = new RegExp($(this).data('id'), 'g');
    time = new Date().getTime();
    new_fields = $(this).data('fields').replace(old_id, time)

    $('.row').append(new_fields);
  })
})