import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["content"];

  // ACTIONS

  toggle() {
    if (this.contentTarget.hidden) {
      this.contentTarget.hidden = false;
    } else {
      this.contentTarget.hidden = true;
    }
  }
}