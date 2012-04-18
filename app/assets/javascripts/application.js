//= require jquery
//= require jquery-ui-1.8.16.custom.min
//= require jquery_ujs
//= require rails.validations
//= require jquery.colorbox.min
//= require_self

jQuery(function($) {

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

  $('button[data-url]:not([data-popin])').live('click', function(evt) {
    evt.preventDefault();

    if ($(this).data('target') == '_blank') {
      window.open($(this).data('url'));
    }
    else {
      window.location = $(this).data('url');
    }
  });

  $('a[data-popin], button[data-popin]').live('click', popinHandler);
  $('form[data-popin]').live('submit', popinHandler);

  $('.army_list_units_overview')
    .sortable({
      update: function(event, ui) {
        $.post($(this).data('url'), $(this).sortable('serialize'));
      }
    })
    .disableSelection()
  ;

  $('.army_list_unit_overview .name').live('click', function() {
    $(this).closest('.army_list_unit_overview').next('.army_list_unit_details').slideToggle('fast');
  });

  $('.army_list_unit_overview .actions select').live('change', function() {
    $(this).closest('form').attr('action', $(this).val());
  });

  $('input[data-radio]:not([data-depend])').live('click', function() {
    $(this).closest('ul').find('input[data-radio]').not(this).prop('checked', false).change();
  });

  $('#army_list_unit_magic_items ul li strong').live('click', function() {
    $('#army_list_unit_magic_items ul li ul').not($(this).next('ul')).slideUp('fast');
    $(this).next('ul').slideToggle('fast', function() { $.colorbox.resize(); });
  });

  $('#army_list_unit_unit_options input, #army_list_unit_magic_items input').live('change', function() {
    var total    = 0.0,
        $changed = $(this),
        $div     = $changed.closest('div');

    $div.find('input:checked').each(function() {
      var value_points = parseFloat($(this).parent('label').prev('em').find('span').html().replace(',', '.'));

      if ($div.data('value-points-limit')) {
        if (total + value_points > parseFloat($div.data('value-points-limit'))) {
          $changed.prop('checked', false);
          return true;
        }
      }

      total += value_points
    });

    $div.find('h3 span').html(String(total).replace('.', ','));
  });

  $('.edit_army_list_unit .army_list_unit_troop_size:first').live('keyup', function() {
    var size = $(this).val();

    $('#army_list_unit_unit_options input[data-per-model]').each(function() {
      var value_points = size * parseFloat($(this).data('value-points'));

      $(this).parent('label').prev('em').find('span').html(String(value_points).replace('.', ','));
      $(this).change();
    });
  });

});

function popinHandler(evt)
{
  evt.preventDefault();

  var $this = $(this),
      url;

  if ($this.is('a')) {
    url = $this.attr('href');
  }
  else if ($this.is('form')) {
    url = $(this).attr('action');
  }
  else if ($this.is('[data-url]')) {
    url = $(this).data('url');
  }

  popin(url);
}

function popin(url)
{
  $.colorbox({
    href: url,
    close: '',
    opacity: 0.4,
    returnFocus: false,
    scrolling: false,
    onComplete: function() {
      $('#cboxClose').css('opacity', 1);
      $('#cboxLoadedContent form[data-validate]').validate();

      $('.edit_army_list_unit [data-depend]').each(function() {
        var $slave = $(this);

        $('#army_list_unit_unit_option_ids_' + $slave.data('depend')).change(function() {
          if ($(this).prop('checked')) {
            if ($slave.is('ul')) {
              $slave.find('input').prop('disabled', false);
            }
            else {
              $slave.prop('disabled', false);
            }
          }
          else {
            if ($slave.is('ul')) {
              $slave.find('input').prop('disabled', true).prop('checked', false);
            }
            else {
              $slave.prop('disabled', true).prop('checked', false);
            }
          }
        }).change();
      });
    },
    onClosed: function() {
      $('#cboxClose').css('opacity', 0);
    }
  });
}
