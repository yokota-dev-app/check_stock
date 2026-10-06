import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["option", "panel"]

  select(event) {
    const selectedId = event.currentTarget.dataset.listId

    this.optionTargets.forEach((option) => {
      option.setAttribute("aria-pressed", String(option.dataset.listId === selectedId))
    })

    this.panelTargets.forEach((panel) => {
      panel.hidden = panel.dataset.listId !== selectedId
    })
  }
}