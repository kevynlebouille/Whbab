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

  $('.popin').click(function(evt) {
    evt.preventDefault();

    $.colorbox({
      href: $(this).data('url') ? $(this).data('url') : $(this).attr('href'),
      close: '',
      opacity: 0.4,
      returnFocus: false,
      scrolling: false,
      initialWidth: 300,
      initialHeight: 200,
      onComplete: function() {
        $('#cboxLoadedContent form[data-validate]').validate();

        $('#army_list_unit_unit_options_form :input[data-depend]').each(function() {
          var $slave = $(this);

          $('#army_list_unit_unit_options_' + $slave.data('depend')).change(function() {
            if ($(this).prop('checked')) {
              $slave.prop('disabled', false);
            }
            else {
              $slave.prop('disabled', true).prop('checked', false);
            }
          }).change();
        });
      }
    });
  });

  $('.army_list_units_overview')
    .sortable({
      update: function(event, ui) {
        $.post($(this).data('url'), $(this).sortable('serialize'));
      }
    })
    .disableSelection()
  ;

  $('.army_list_unit_overview .name').click(function() {
    $(this).closest('.army_list_unit_overview').next('.army_list_unit_details').slideToggle();
  });

  $('input[data-radio]').live('click', function() {
    $(this).closest('ul').find('input[data-radio]').not(this).prop('checked', false);
  });

});