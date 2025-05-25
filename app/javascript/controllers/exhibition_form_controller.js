import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["center", "rooms"]

  connect() {
    if (!this.centerTarget.value) {
      this.roomsTarget.disabled = true
    }
  }

  async updateRooms() {
    const centerId = this.centerTarget.value
    
    if (!centerId) {
      this.roomsTarget.innerHTML = '<option value="">Select a room</option>'
      this.roomsTarget.disabled = true
      return
    }

    try {
      const response = await fetch(`/admin/exhibition_centers/${centerId}/rooms.json`)
      const rooms = await response.json()
      
      this.roomsTarget.innerHTML = '<option value="">Select a room</option>' +
        rooms.map(room => `<option value="${room.id}">${room.name}</option>`).join('')
      
      this.roomsTarget.disabled = false
    } catch (error) {
      console.error('Error loading rooms:', error)
      this.roomsTarget.innerHTML = '<option value="">Error loading rooms</option>'
      this.roomsTarget.disabled = true
    }
  }
}
