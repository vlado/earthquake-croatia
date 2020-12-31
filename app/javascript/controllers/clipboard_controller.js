// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import ClipboardJS from "clipboard"

export default class extends Controller {
  static targets = [ "button" ];

  connect() {
    var clipboard = new ClipboardJS(this.button);
    clipboard.on('success', function(e) {
      alert('Poveznica kopirana')
    });
  }

  // GETTERS AND SETTERS

  get button() {
    return this.targets.find("button");
  }
}
