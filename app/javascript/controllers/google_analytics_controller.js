import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    if (typeof gtag === 'function') {
      gtag('config', '<%= Rails.application.credentials.dig(:google_analytics) %>', {
        'page_location': document.location.href
      })
    }
  }
}

