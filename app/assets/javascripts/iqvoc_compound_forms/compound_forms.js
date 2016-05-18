/*jslint vars: true, unparam: true, browser: true */
/*global jQuery, IQVOC */

jQuery(document).ready(function($) {
  "use strict";

  $("input[type=button].add-compound-form").on("click", function(ev) {
    var original = $(this).closest(".compound-form");
    var clone = original.clone(true);
    var container = $("div.entity_select", clone);
    var el = $("input.entity_select", clone).
      attr("data-entities", "").val("").insertBefore(container);
    container.remove();
    clone.insertAfter(original);
    new IQVOC.EntitySelector(el[0]);

    $("ul.entity_list", clone).html("");
  });

  $("input[type=button].rm-compound-form").click(function(ev) {
    // clear compound form values
    $(this).parent().find('input.entity_select').val("");

    // hide the <li> that contains the widget
    // don't drop it to keep cleared form inputs
    $(this).parent().parent().hide();
  });
});
