// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import ClipboardJS from "clipboard"
// import * as ActiveStorage from "@rails/activestorage"
// import "channels"

Rails.start()
Turbolinks.start()
// ActiveStorage.start()

document.addEventListener("turbolinks:load", function(event) {

  if (typeof gtag === 'function') {
    gtag('config', '<%= Rails.application.credentials.dig(:google_analytics) %>', {
      'page_location': event.data.url
    })
  }

  let $filterShowLink = $('a#filter-show');
  let $filterHideLink = $('a#filter-hide');
  let $filterCard = $('#filter-card');

  var clipboard = new ClipboardJS('button.copy-clipboard');
  clipboard.on('success', function(e) {
    alert('Poveznica kopirana')
  });

  $filterCard.hide();

  $filterShowLink.on("click", function(e) {
    e.preventDefault();
    $filterCard.show();
    $filterShowLink.hide()
  });

  $filterHideLink.on("click", function(e) {
    e.preventDefault();
    $filterCard.hide();
    $filterShowLink.show()
  });

})

