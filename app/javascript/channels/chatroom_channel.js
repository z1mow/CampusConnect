import consumer from "./consumer";

document.addEventListener("turbolinks:load", () => {
  const messagesContainer = document.getElementById("messages");

  if (messagesContainer) {
    const communityGroupId = messagesContainer.dataset.communityGroupId;

    consumer.subscriptions.create(
      { channel: "ChatroomChannel", community_group_id: communityGroupId },
      {
        connected() {
          console.log("Connected to ChatroomChannel");
        },

        disconnected() {
          console.log("Disconnected from ChatroomChannel");
        },

        received(data) {
          console.log("Received data:", data);
          if (messagesContainer) {
            messagesContainer.insertAdjacentHTML("beforeend", data);
          } else {
            console.error("Messages container not found!");
          }
        },
      }
    );
  }
});
