import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "status"]

  connect() {
    this.savedValue = this.checkboxTarget.checked
  }

  save() {
    this.statusTarget.textContent = this.checkboxTarget.checked ? "完了" : "アクティブ"
    this.element.requestSubmit()
  }

  submitted(event) {
    if (event.detail.success) {
      this.savedValue = this.checkboxTarget.checked
      return
    }

    this.checkboxTarget.checked = this.savedValue
    this.statusTarget.textContent = this.savedValue ? "完了" : "アクティブ"
  }
}