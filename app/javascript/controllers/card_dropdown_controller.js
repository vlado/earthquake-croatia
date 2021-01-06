import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["dropdown"];

  // ACTIONS

  toggle() {
    this.dropdownTarget.classList.toggle("is-active");
  }
}
