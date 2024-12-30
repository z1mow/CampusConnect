import consumer from "./consumer"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    console.log("Connected to NotificationChannel")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Bildirim sayısını güncelle
    const notificationCount = document.querySelector('#notifications-dropdown .circular.label')
    const notificationsMenu = document.querySelector('#notifications-dropdown .scrolling.menu')
    
    if (data.count > 0) {
      if (notificationCount) {
        notificationCount.textContent = data.count
      } else {
        const label = document.createElement('div')
        label.className = 'ui red circular label'
        label.style.marginLeft = '5px'
        label.textContent = data.count
        document.querySelector('#notifications-dropdown .bell.icon').after(label)
      }
    } else if (notificationCount) {
      notificationCount.remove()
    }

    // Yeni bildirimi menüye ekle
    if (data.notification && notificationsMenu) {
      notificationsMenu.insertAdjacentHTML('afterbegin', data.notification)
    }

    // Sesli bildirim
    const audio = new Audio('/notification.mp3')
    audio.play()
  }
}) 