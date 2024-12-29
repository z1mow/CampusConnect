import consumer from "./consumer"

consumer.subscriptions.create("DirectMessageChannel", {
  connected() {
    console.log("Connected to DirectMessageChannel")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const messagesContainer = document.getElementById('messages')
    if (messagesContainer) {
      messagesContainer.insertAdjacentHTML('beforeend', data.message)
      messagesContainer.scrollTop = messagesContainer.scrollHeight
    }
  }
}) 