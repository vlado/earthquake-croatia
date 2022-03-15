// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
// import Turbolinks from "turbolinks";
import $ from "jquery";
import "select2";
import "select2/dist/css/select2.css";
import langhr from "select2/src/js/select2/i18n/hr";

// import * as ActiveStorage from "@rails/activestorage"
// import "channels"

Rails.start();
// Turbolinks.start();
// ActiveStorage.start()

import "controllers";

document.addEventListener("DOMContentLoaded", function() {
  $.fn.select2.defaults.set("language", langhr);

  $(".select2-container").remove(); //remove the select2 container DOM
  $("#city_id").select2(); // Select2 will just reinit the DOM
  let $newAddCitySelect = $("#ad_city_id");

  $newAddCitySelect.select2({
    ajax: {
      url: $newAddCitySelect.data("url"),
      dataType: "json",
      delay: 200
    },
    minimumInputLength: 3
  });
});
