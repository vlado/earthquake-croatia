import { Controller } from "stimulus";
import ClipboardJS from "clipboard";
import toastr from "toastr";

export default class extends Controller {
  static targets = [ "button" ];

  connect() {
    var clipboard = new ClipboardJS(this.button);
    clipboard.on("success", function() {
      toastr.success("Poveznica kopirana", "", {
        closeButton: false, progressBar: false, timeOut: 2000, positionClass: "toast-top-center"
      });
    });
  }

  // GETTERS AND SETTERS

  get button() {
    return this.targets.find("button");
  }
}
