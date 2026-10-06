import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fields", "template", "title", "memo"]

  add() {
    const index = this.fieldsTarget.querySelectorAll("[data-item-field]").length
    const fields = this.templateTarget.innerHTML.replaceAll("NEW_RECORD", String(index))
    this.fieldsTarget.insertAdjacentHTML("beforeend", fields)
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

    if (items.length === 0) this.add()
  }
}