# DocuSync

**DocuSync** is a real-time collaborative platform enabling document editing, file sharing, and Chatting. Built using Flutter (frontend), Node.js (backend), MongoDB (database). It leverages Socket.IO for real-time communication and JWT-based authentication for secure access.


<table>
  <tr>
    <td><img src="assets/screenshots/login screen.png" width="500"/></td>
    <td><img src="assets/screenshots/home screen.png" width="500"/></td>
  </tr>
  <tr>
    <td><img src="assets/screenshots/document screen.png" width="500"/></td>
    <td><img src="assets/screenshots//file share screen.png" width="500"/></td>
  </tr>
</table>

---


## 🚀 Features

- 📄 **Real-time Document Editing**  
  Collaborate with multiple users on the same document with live updates.

- 📁 **File Sharing**  
  Share files instantly with other participants in a session.

- 💬 **Chatting**  
  Seamless real time chatting between users.

- 🔄 **Live Synchronization**  
  Utilizes Socket.IO to synchronize data instantly between clients.

- 🔐 **Secure Sessions**  
  JWT-based authentication and authorization ensure user identity and session integrity.

---

## 🛠️ Tech Stack

| Layer        | Technology                         |
|--------------|------------------------------------|
| Frontend     | Flutter                            |
| Backend      | Node.js, Express.js                |
| Database     | MongoDB                            |
| Realtime     | Socket.IO                          |
| Auth         | JWT (JSON Web Tokens)              |

---
## Backend Architecture Overview

### Socket.IO
- Used for all real-time interactions, including document edits, file transfers, and call signaling.

---
