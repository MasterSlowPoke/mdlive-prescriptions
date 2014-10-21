$( function() {
  $('.add_fields').click(function(e) { 
    e.preventDefault();

    old_id = new RegExp($(this).data('id'), 'g');
    time = new Date().getTime();

    $('.row').append(
        $(this).data('fields').replace(old_id, time)
      );

    console.log(old_id);
  })
})