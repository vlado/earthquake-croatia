import { Controller } from "stimulus";
import ClipboardJS from "clipboard";

export default class extends Controller {
  static targets = [ "button" ];

  connect() {
    var clipboard = new ClipboardJS(this.button);
    clipboard.on("success", function() {
      alert("Poveznica kopirana");
    });
  }

  // GETTERS AND SETTERS

  get button() {
    return this.targets.find("button");
  }
}
