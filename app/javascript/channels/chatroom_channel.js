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
          // Called when the subscription has been terminated by the server
        },

        received(data) {
          if (data.html) {
            messagesContainer.insertAdjacentHTML("beforeend", data.html);
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
          }
        }
      }
    );
  }
});
