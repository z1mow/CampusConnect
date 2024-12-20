import consumer from "./consumer";

consumer.subscriptions.create("ChatroomChannel", {
  connected() {
    console.log("Connected to ChatroomChannel");
  },

  disconnected() {
    console.log("Disconnected from ChatroomChannel");
  },

  received(data) {
    console.log("Received data:", data);
    const messagesContainer = document.getElementById("messages");
    if (messagesContainer) {
      messagesContainer.insertAdjacentHTML("beforeend", data);
    } else {
      console.error("Messages container (id='messages') bulunamadı!");
    }
  }
  
});
