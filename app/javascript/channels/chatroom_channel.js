import consumer from "./consumer";

document.addEventListener("turbolinks:load", () => {
  const messagesContainer = document.getElementById("messages");

  if (messagesContainer) {
    const communityGroupId = messagesContainer.dataset.communityGroupId;

    consumer.subscriptions.create(
      { channel: "ChatroomChannel", community_group_id: communityGroupId },
      {
        connected() {
          console.log(`Connected to ChatroomChannel for Community Group ID: ${communityGroupId}`);
        },

        disconnected() {
          console.log("Disconnected from ChatroomChannel");
        },

        received(data) {
          console.log("Received data:", data);
          // Yeni mesajı DOM'a ekle
          messagesContainer.insertAdjacentHTML("beforeend", data);
          // Otomatik kaydırma (opsiyonel)
          messagesContainer.scrollTop = messagesContainer.scrollHeight;
        },
      }
    );
  }
});
