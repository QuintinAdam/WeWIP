import { Controller } from "@hotwired/stimulus"
import Timeago from "stimulus-timeago"

export default class extends Timeago {
  connect() {
    super.connect()
    console.log("Do what you want here.")
  }
}
