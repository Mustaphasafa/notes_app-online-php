# 📝 Simple Notes App – Flutter + PHP + MySQL

This is a beginner-level mobile notes app built using *Flutter* as the frontend and *PHP + MySQL* as the backend. The app allows user registration, login, creating notes with optional image upload, and basic security validation.

---

## 📱 Features

- 🔐 User authentication (register/login)
- 🗒️ Create and delete text notes & edit
- 🖼️ Upload and display images with notes
- 🧪 Form validation (e.g. checks if email contains @gmail.com)
- 📥 Image uploads go to /upload folder on the server
- 💾 Uses SharedPreferences to keep user logged in
- 🛡️ Basic input security:
  - htmlspecialchars()
  - strip_tags()

---

## 🛠️ Technologies Used

- Flutter (Dart)
- PHP (Vanilla, no framework)
- MySQL
- HTTP Multipart for image upload
- SharedPreferences (Flutter local storage)

---

## ⚠️ Notes

- The UI is kept simple and minimal — this project is for learning purposes.
- The app is not a full-stack solution, but it covers real backend communication and user session handling.
- API calls use custom HTTP headers (e.g., id, token) for access.

---

## 🔗 Useful Links

- GitHub Profile: [github.com/Mustaphasafa](https://github.com/Mustaphasafa)
- Telegram: [@mostafasafaBJ](https://t.me/mostafasafaBJ)

---

## 📸 Screenshots (Optional)

![register](
https://i.imgur.com/IMwwHRz.jpeg
)
![login](
https://i.imgur.com/PVoE5Bo.jpeg
)
![1](
https://i.imgur.com/wiTO2nV.jpeg
)
![2](
https://i.imgur.com/HclFjMA.jpeg
)
![3](
https://i.imgur.com/O0LwzJH.jpeg
)



---

## 📂 Server File Structure (Optional)

```bash
/
    connect.php             # Database connection
/auth
    login.php
    signup.php
/notes
    add.php
    view.php
    edit.php
    delete.php
/upload
