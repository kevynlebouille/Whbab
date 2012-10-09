//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require rails.validations
//= require jquery.formalize
//= require jquery.colorbox
//= require jquery.ui.touch-punch

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
      handle: '.position',
      update: function(event, ui) {
        $.post($(this).data('url'), $(this).sortable('serialize'), function() {
          $('.army_list_units_overview .position').each(function(index) {
            $(this).html(index < 9 ? '0' + (index+1) : index+1);
          });
        });
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

  $('#army_list_unit_magic_items ul li strong').live('click', function() {
    $('#army_list_unit_magic_items ul li ul').not($(this).next('ul')).slideUp('fast');
    $(this).next('ul').slideToggle('fast', function() { $.colorbox.resize(); });
  });

  $('#army_list_unit_unit_options input, #army_list_unit_magic_items input, #army_list_unit_magic_standards input').live('change', function(evt) {
    var total     = 0.0,
        $changed  = $(this),
        $slaves   = $('.edit_army_list_unit input[data-depend='+$changed.val()+']'),
        $siblings = $changed.closest('ul').find('> li > label input[data-radio]').not($changed),
        $div      = $changed.closest('div');

    // console.log($changed.parent().contents(':not(input)').text() + ' changed !');

    $div.find('input:checked').each(function() {
      var value_points = parseFloat($(this).parent('label').prev('em').find('span').html().replace(',', '.'));

      if ($div.data('value-points-limit')) {
        if (total + value_points > parseFloat($div.data('value-points-limit'))) {
          $changed.prop('checked', false);
          updateArmyListUnitDepend($changed);
          evt.stopPropagation();
          return false;
        }
      }

      total += value_points;
    });

    if (evt.isPropagationStopped()) {
      return false;
    }

    if ($changed.data('radio') && $changed.prop('checked')) {
      $siblings.prop('checked', false).each(function() {
        updateArmyListUnitDepend($(this));
      });
    }

    updateArmyListUnitDepend($changed);

    updateArmyListUnitValuePoints();
  });

  $('.edit_army_list_unit #army_list_unit_army_list_unit_troops_attributes_0_size').live('keyup', function() {
    var size = parseInt($(this).val());

    if (isNaN(size)) return false;

    $('#army_list_unit_unit_options input[data-per-model]').each(function() {
      var value_points = size * parseFloat($(this).data('value-points'));

      $(this).parent('label').prev('em').find('span').html(String(value_points).replace('.', ','));
    });

    updateArmyListUnitValuePoints();
  });

});

function updateArmyListUnitDepend($changed)
{
  var $slaves = $('.edit_army_list_unit input[data-depend='+$changed.val()+']');

  if ($changed.prop('checked')) {
    $slaves.attr('disabled', false);
  }
  else {
    $slaves.prop('disabled', true).prop('checked', false).each(function() {
      updateArmyListUnitDepend($(this));
    });
  }
}

function updateArmyListUnitValuePoints()
{
  $('#army_list_unit_unit_options, #army_list_unit_magic_items, #army_list_unit_magic_standards').each(function() {
    var total = 0.0,
        $div  = $(this);

    $div.find('input:checked').each(function() {
      var value_points = parseFloat($(this).parent('label').prev('em').find('span').html().replace(',', '.'));

      total += value_points;
    });

    $div.find('h3 span').html(String(total).replace('.', ','));
  });

  var total  = 0.0,
      $popin = $('.popin');

  if ($('#army_list_unit_troops').length) {
    $('#army_list_unit_troops tr').each(function() {
      var size         = parseInt($(this).find('.army_list_unit_troop_size').val()),
          value_points = parseFloat($(this).data('value-points'));

      if (isNaN(size)) return;

      total += size * value_points;
    });
  }
  else {
    total = parseFloat($popin.find('h1').data('value-points'));
  }

  if ($('#army_list_unit_unit_options').length) {
    total += parseFloat($('#army_list_unit_unit_options h3 span').html().replace(',', '.'));
  }

  if ($('#army_list_unit_magic_items').length) {
    total += parseFloat($('#army_list_unit_magic_items h3 span').html().replace(',', '.'));
  }

  if ($('#army_list_unit_magic_standards').length) {
    total += parseFloat($('#army_list_unit_magic_standards h3 span').html().replace(',', '.'));
  }

  $popin.find('h1 span').html(String(total).replace('.', ','));
}

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
      $('#cboxLoadedContent form :input:visible:first').focus();
      $('#cboxLoadedContent form[data-validate]').validate();

      var masters = [];
      $('#army_list_unit_unit_options input[data-depend], #army_list_unit_magic_items input[data-depend], #army_list_unit_magic_standards input[data-depend]').each(function() {
        masters.push('#army_list_unit_unit_option_ids_' + $(this).data('depend'));
      });

      $(masters.join(', ')).change();
    },
    onClosed: function() {
      $('#cboxClose').css('opacity', 0);
    }
  });
}
