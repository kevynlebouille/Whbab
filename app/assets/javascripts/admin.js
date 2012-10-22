jQuery(function($) {
  // UNIT OPTION - PARENT_ID
  $('#unit_option_parent_id').clone().attr('id', 'unit_option_parent_id_clone').hide().appendTo('body');
  $('#unit_option_unit_id').change(function() {
    var $unit = $(this).find('option[value=' + this.value + ']');

    $('#unit_option_parent_id').html($('#unit_option_parent_id_clone').html());

    $('#unit_option_parent_id option').each(function() {
      var $option = $(this);

      if ($unit.html() && $option.html() && $option.html().indexOf($unit.html() + ' - ') !== 0) {
        $option.remove();
      }
    });
  }).change();

  // EQUIPEMENT - ARMY_FILTER
  $('#equipment_unit_id').clone().attr('id', 'equipment_unit_id_clone').hide().appendTo('body');
  $('#equipment_troop_id').clone().attr('id', 'equipment_troop_id_clone').hide().appendTo('body');

  $('#equipment_army_filter').change(function() {
    var $filter = $(this).find('option[value=' + this.value + ']');

    $('#equipment_unit_id').html($('#equipment_unit_id_clone').html());

    $('#equipment_unit_id option').each(function() {
      var $option = $(this);

      if ($filter.html() && $option.html() && $option.html().indexOf($filter.html() + ' - ') !== 0) {
        $option.remove();
      }
    });

    $('#equipment_troop_id').html($('#equipment_troop_id_clone').html());

    $('#equipment_troop_id option').each(function() {
      var $option = $(this);

      if ($filter.html() && $option.html() && $option.html().indexOf($filter.html() + ' - ') !== 0) {
        $option.remove();
      }
    });
  }).change();

  // EQUIPEMENT - TROOP
  $('#equipment_unit_id').change(function() {
    var $filter = $(this).find('option[value=' + this.value + ']');

    $('#equipment_troop_id').html($('#equipment_troop_id_clone').html());

    $('#equipment_troop_id option').each(function() {
      var $option = $(this);

      if ($filter.html() && $option.html() && $option.html().indexOf($filter.html() + ' - ') !== 0) {
        $option.remove();
      }
    });
  }).change();

  // SPECIAL_RULE - ARMY_FILTER
  $('#special_rule_unit_id').clone().attr('id', 'special_rule_unit_id_clone').hide().appendTo('body');
  $('#special_rule_troop_id').clone().attr('id', 'special_rule_troop_id_clone').hide().appendTo('body');

  $('#special_rule_army_filter').change(function() {
    var $filter = $(this).find('option[value=' + this.value + ']');

    $('#special_rule_unit_id').html($('#special_rule_unit_id_clone').html());

    $('#special_rule_unit_id option').each(function() {
      var $option = $(this);

      if ($filter.html() && $option.html() && $option.html().indexOf($filter.html() + ' - ') !== 0) {
        $option.remove();
      }
    });

    $('#special_rule_troop_id').html($('#special_rule_troop_id_clone').html());

    $('#special_rule_troop_id option').each(function() {
      var $option = $(this);

      if ($filter.html() && $option.html() && $option.html().indexOf($filter.html() + ' - ') !== 0) {
        $option.remove();
      }
    });
  }).change();

  // SPECIAL_RULE - TROOP
  $('#special_rule_unit_id').change(function() {
    var $filter = $(this).find('option[value=' + this.value + ']');

    $('#special_rule_troop_id').html($('#special_rule_troop_id_clone').html());

    $('#special_rule_troop_id option').each(function() {
      var $option = $(this);

      if ($filter.html() && $option.html() && $option.html().indexOf($filter.html() + ' - ') !== 0) {
        $option.remove();
      }
    });
  }).change();

  // TROOP - ARMY_FILTER
  $('#troop_unit_id').clone().attr('id', 'troop_unit_id_clone').hide().appendTo('body');
  $('#troop_unit_option_id').clone().attr('id', 'troop_unit_option_id_clone').hide().appendTo('body');

  $('#troop_army_filter').change(function() {
    var $filter = $(this).find('option[value=' + this.value + ']');

    $('#troop_unit_id').html($('#troop_unit_id_clone').html());

    $('#troop_unit_id option').each(function() {
      var $option = $(this);

      if ($filter.html() && $option.html() && $option.html().indexOf($filter.html() + ' - ') !== 0) {
        $option.remove();
      }
    });

    $('#troop_unit_option_id').html($('#troop_unit_option_id_clone').html());

    $('#troop_unit_option_id option').each(function() {
      var $option = $(this);

      if ($filter.html() && $option.html() && $option.html().indexOf($filter.html() + ' - ') !== 0) {
        $option.remove();
      }
    });
  }).change();

  // TROOP - UNIT_OPTION
  $('#troop_unit_id').change(function() {
    var $filter = $(this).find('option[value=' + this.value + ']');

    $('#troop_unit_option_id').html($('#troop_unit_option_id_clone').html());

    $('#troop_unit_option_id option').each(function() {
      var $option = $(this);

      if ($filter.html() && $option.html() && $option.html().indexOf($filter.html() + ' - ') !== 0) {
        $option.remove();
      }
    });
  }).change();
});