import { Controller } from "stimulus";
import $ from "jquery";

export default class extends Controller {
  static targets = ["container", "show_button"];

  connect() {
    this.hide();
  }

  // ACTIONS

  show(event) {
    if (event) {
      event.preventDefault();
    }

    this.container.show();
    this.showButton.hide();
  }

  hide(event) {
    if (event) {
      event.preventDefault();
    }

    this.container.hide();
    this.showButton.show();
  }

  // GETTERS AND SETTERS

  get container() {
    return $(this.targets.find("container"));
  }

  get showButton() {
    return $(this.targets.find("show_button"));
  }
}

