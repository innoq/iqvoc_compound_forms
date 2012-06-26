/*jslint vars: true, unparam: true, browser: true */
/*global jQuery, IQVOC */

jQuery(document).ready(function($) {
  "use strict";

  $("input[type=button].add-compound-form").live("click", function(ev) {
    var original = $(this).closest("li");
    var clone = original.clone();
    var container = $("div.entity_select", clone);
    var el = $("input.entity_select", clone).
      attr("data-entities", "").val("").insertBefore(container);
    container.remove();
    clone.insertAfter(original);
    new IQVOC.EntitySelector(el[0]);
  });

  $("input[type=button].rm-compound-form").click(function(ev) {
    // Remove the <li> that contains the widget
    $(this).parent().remove();
  });
});
