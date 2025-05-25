import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "description"]

  connect() {
    this.updateDescription()
  }

  updateDescription() {
    const select = this.selectTarget
    const selectedOption = select.options[select.selectedIndex]
    const descriptions = JSON.parse(select.dataset.descriptions || '{}')
    const description = descriptions[select.value]
    
    if (description) {
      this.descriptionTarget.textContent = description
    } else {
      this.descriptionTarget.textContent = ""
    }
  }
}
