import { Controller } from "stimulus";
import ClipboardJS from "clipboard";
import { toast } from "bulma-toast";

export default class extends Controller {
  static targets = [ "button" ];

  connect() {
    var clipboard = new ClipboardJS(this.button);
    clipboard.on("success", function() {
      toast({
        message: "<span class='icon mr-2'><svg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='currentColor'><path stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M5 13l4 4L19 7' /></svg></span>Poveznica kopirana",
        type: "is-success",
        position: "top-center",
        closeOnClick: true,
        opacity: 0.9,
      });
    });
  }

  // GETTERS AND SETTERS

  get button() {
    return this.targets.find("button");
  }
}
