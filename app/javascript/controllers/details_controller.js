import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggleOpen(event) {
    document.querySelectorAll('details').forEach(details => { details.open = !details.open })
  }
}
