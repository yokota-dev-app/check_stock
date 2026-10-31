import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fields", "template", "title", "memo"]

  add() {
    const index = this.fieldsTarget.querySelectorAll("[data-item-field]").length
    const fields = this.templateTarget.innerHTML.replaceAll("NEW_RECORD", String(index))
    this.fieldsTarget.insertAdjacentHTML("beforeend", fields)
    this.keepFirstLabelOnly()
  }

  keepFirstLabelOnly() {
    this.fieldsTarget.querySelectorAll("[data-item-field]").forEach((field, index) => {
      if (index === 0) return
      const label = field.querySelector("label")
      if (!label) return
      field.querySelector("input")?.setAttribute("aria-label", label.textContent.trim())
      label.remove()
    })
  }

  applyTemplate(event) {
    const { title, memo, items } = event.detail
    this.titleTarget.value = title
    this.memoTarget.value = memo
    this.fieldsTarget.replaceChildren()

    items.forEach((name, index) => {
      const template = document.createElement("template")
      template.innerHTML = this.templateTarget.innerHTML.replaceAll("NEW_RECORD", String(index))
      template.content.querySelector('input[name$="[name]"]').value = name
      this.fieldsTarget.append(template.content)
    })
    this.keepFirstLabelOnly()

    if (items.length === 0) this.add()
  }
}