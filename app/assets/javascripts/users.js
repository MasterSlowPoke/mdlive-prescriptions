$(function() {
  $('#toggle-email a, #toggle-text a').click(function(e) {
    console.log('clicked');

    $(this).attr('disabled', true);
    $(this).after('<img src="/assets/spinner.gif">');
  });
});