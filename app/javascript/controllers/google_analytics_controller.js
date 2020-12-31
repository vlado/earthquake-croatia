import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    if (typeof gtag === "function") {
      gtag("config", "<%= Rails.application.credentials.dig(:google_analytics) %>", { // eslint-disable-line no-undef
        "page_location": document.location.href
      });
    }
  }
}

