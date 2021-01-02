import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["content", "chevron"];

  // ACTIONS

  toggle() {
    this.contentTarget.hidden = !this.contentTarget.hidden;
    this.chevronTarget.classList.toggle("down");
  }
}
