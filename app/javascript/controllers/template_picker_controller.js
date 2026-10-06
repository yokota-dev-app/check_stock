import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog", "title", "memo", "items", "apply"]

  open() {
    this.dialogTarget.showModal()
  }

  close() {
    this.dialogTarget.close()
  }

  select(event) {
    const { title, memo, items } = event.params
    const itemNames = Array.isArray(items) ? items : JSON.parse(items)
    this.selectedTemplate = { title, memo, items: itemNames }
    this.titleTarget.textContent = title
    this.memoTarget.textContent = memo
    this.itemsTarget.replaceChildren(...this.selectedTemplate.items.map((name) => {
      const item = document.createElement("li")
      item.textContent = name
      return item
    }))
    this.applyTarget.disabled = false

    this.element.querySelectorAll(".template-picker-option").forEach((option) => {
      option.setAttribute("aria-pressed", String(option === event.currentTarget))
    })
  }

  apply() {
    if (!this.selectedTemplate) return

    this.dispatch("apply", { detail: this.selectedTemplate })
    this.dialogTarget.close()
  }
}