//= require jquery
//= require jquery-ui-1.8.16.custom.min
//= require jquery_ujs
//= require rails.validations
//= require jquery.colorbox.min
//= require_self

jQuery(function($) {

  $('.home .signup #user_new').change(function() {
    $('.home .signup #user_password_confirmation').val($('.home .signup #user_password').val());
  });

  $('#header .welcome strong').click(function() {
    $(this).toggleClass('over');
    $('#header .menu').css('width', $(this).css('width')).toggle();
  });

  $('body').click(function(evt) {
    $('#header .menu').hide();
    $('#header .welcome strong').removeClass('over')
  });

  $('#header').click(function(evt){
    evt.stopPropagation();
  });

  $('a.popin').colorbox({
    close: '',
    opacity: 0.4,
    returnFocus: false,
    scrolling: false,
    initialWidth: 300,
    initialHeight: 200,
    onComplete: function() {
      $('#cboxLoadedContent form[data-validate]').validate();
    }
  });

  $('button.popin').click(function() {
    $.colorbox({
      href: $(this).data('url'),
      close: '',
      opacity: 0.4,
      returnFocus: false,
      scrolling: false,
      initialWidth: 300,
      initialHeight: 200,
      onComplete: function() {
        $('#cboxLoadedContent form[data-validate]').validate();
      }
    });
  });

  $('.army_list_choices_overview').sortable({
    update: function(event, ui) {
      $.post($(this).data('url'), $(this).sortable('serialize'));
    }
  }).disableSelection();
});