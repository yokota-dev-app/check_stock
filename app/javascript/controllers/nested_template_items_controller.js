import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fields", "template"]

  add() {
    const index = this.fieldsTarget.querySelectorAll("[data-template-item-field]").length
    const fields = this.templateTarget.innerHTML.replaceAll("NEW_RECORD", String(index))
    this.fieldsTarget.insertAdjacentHTML("beforeend", fields)
    this.keepFirstLabelOnly()
  }

  keepFirstLabelOnly() {
    this.fieldsTarget.querySelectorAll("[data-template-item-field]").forEach((field, index) => {
      if (index === 0) return
      const label = field.querySelector("label")
      if (!label) return
      field.querySelector("input")?.setAttribute("aria-label", label.textContent.trim())
      label.remove()
    })
  }
}