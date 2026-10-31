import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle", "menu"]

  toggle() {
    this.menuTarget.hidden ? this.open() : this.close()
  }

  open() {
    this.menuTarget.hidden = false
    this.toggleTarget.setAttribute("aria-expanded", "true")
  }

  close() {
    this.menuTarget.hidden = true
    this.toggleTarget.setAttribute("aria-expanded", "false")
  }

  closeOutside(event) {
    if (!this.element.contains(event.target)) this.close()
  }

  edit() {
    this.close()
    this.element.closest("article")?.querySelector(".list-detail-title-input")?.focus()
  }
}
