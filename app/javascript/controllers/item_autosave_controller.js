import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field", "checked"]

  connect() {
    this.savedValue = this.fieldTarget.value
    this.savedChecked = this.checkedTarget.checked
    this.submitting = false
  }

  focusout(event) {
    if (event.relatedTarget && this.element.contains(event.relatedTarget)) return
    this.save(event)
  }

  save(event) {
    if (event.type === "keydown") {
      event.preventDefault()
    }

    const value = this.fieldTarget.value.trim()
    const nameChanged = value !== this.savedValue
    const checkedChanged = this.checkedTarget.checked !== this.savedChecked
    if (this.submitting || (!nameChanged && !checkedChanged)) return

    if (!value) {
      this.fieldTarget.value = this.savedValue
      if (!checkedChanged) return
    }

    this.submitting = true
    this.element.requestSubmit()
  }

  submitted(event) {
    this.submitting = false
    if (event.detail.success) {
      this.savedValue = this.fieldTarget.value
      this.savedChecked = this.checkedTarget.checked
    } else {
      this.fieldTarget.value = this.savedValue
      this.checkedTarget.checked = this.savedChecked
    }
  }
}