jQuery(function($) {
  $('#unit_option_parent_id').clone().attr('id', 'unit_option_parent_id_clone').hide().appendTo('body');
  $('#unit_option_depend_id').clone().attr('id', 'unit_option_depend_id_clone').hide().appendTo('body');

  $('#unit_option_unit_id').change(function() {
    var $unit = $(this).find('option[value=' + this.value + ']');

    $('#unit_option_parent_id').html($('#unit_option_parent_id_clone').html());
    $('#unit_option_depend_id').html($('#unit_option_depend_id_clone').html());

    $('#unit_option_parent_id option, #unit_option_depend_id option').each(function() {
      var $option = $(this);

      if ($unit.html() && $option.html() && $option.html().indexOf($unit.html()) !== 0) {
        $option.remove();
      }
    });
  });

  $('#unit_option_unit_id').change();
});