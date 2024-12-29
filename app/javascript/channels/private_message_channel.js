import consumer from "./consumer"

consumer.subscriptions.create("PrivateMessageChannel", {
  connected() {
    console.log("Connected to PrivateMessageChannel")
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