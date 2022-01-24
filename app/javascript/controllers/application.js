import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
import Timeago from "stimulus-timeago"
application.register("timeago", Timeago)
export { application }
