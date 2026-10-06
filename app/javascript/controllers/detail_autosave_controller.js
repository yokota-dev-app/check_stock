import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["title", "memo"]

  connect() {
    this.savedTitle = this.titleTarget.value
    this.savedMemo = this.memoTarget.value
    this.submitting = false
  }

  focusout(event) {
    if (event.relatedTarget && this.element.contains(event.relatedTarget)) return
    this.save(event)
  }

  save(event) {
    if (event.type === "keydown") event.preventDefault()

    const title = this.titleTarget.value.trim()
    const memo = this.memoTarget.value
    const titleChanged = title !== this.savedTitle
    const memoChanged = memo !== this.savedMemo
    if (this.submitting || (!titleChanged && !memoChanged)) return

    if (!title) {
      this.titleTarget.value = this.savedTitle
      if (!memoChanged) return
    } else {
      this.titleTarget.value = title
    }

    this.submitting = true
    this.element.requestSubmit()
  }

  submitted(event) {
    this.submitting = false
    if (event.detail.success) {
      this.savedTitle = this.titleTarget.value
      this.savedMemo = this.memoTarget.value
      const panel = this.element.closest(".list-detail")
      const option = Array.from(document.querySelectorAll(".list-picker-option"))
        .find((element) => element.dataset.listId === panel?.dataset.listId)
      const title = option?.querySelector(".list-picker-title")
      if (title) title.textContent = this.savedTitle
      return
    }

    this.titleTarget.value = this.savedTitle
    this.memoTarget.value = this.savedMemo
  }
}