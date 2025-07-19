# Attendance & Tasks App (Flutter)
A Flutter application built as part of the Flutter Developer test for Portal.lk.  
It allows employees to log attendance and manage their daily tasks with local data persistence and error simulation.

---

## 📱 Features

### 🕒 Attendance
- One-time name entry (stored locally)
- Check-In and Check-Out timestamps
- Automatically displays:
  - Date (MM/DD/YYYY)
  - Day name (e.g., Monday)
  - Check-In time, Check-Out time
  - Time spent (HH:mm)
  - Attendance Status:
    - Present: both Check-In and Check-Out exist
    - Incomplete: only one exists
    - Absent: neither exists
- All records are saved and persist across restarts

### ✅ Tasks
- Add tasks with:
  - Name
  - Due Date (Date Picker)
  - Priority (Low / Medium / High)
  - Status (Not Started / In Progress / Done)
- Update task status
- Persistent across restarts

### ⚠️ Error Simulation
- Long-press AppBar title → "Simulate Error" button appears
- Throws a fake exception to test error handling
- Friendly alert dialog shown to user

### 👤 About Page
- Developer name and submission date are displayed visibly

---

## 🔧 Tech Stack & Packages
- `Flutter` (Stable channel)
- `shared_preferences` – For local storage
- `intl` – For date and time formatting

---

## 🚀 How to Run

### 🐧 On Android:
```bash
flutter run
```

### 🌐 On Web:
```bash
flutter run -d web-server
```
Or build and host using:
```bash
flutter build web
```

## 📂 Folder Structure
```
lib/
├── main.dart                  # Bottom nav, simulate error
├── screens/
│   ├── attendance_screen.dart  # Check-In/Out + status
│   ├── tasks_screen.dart       # Task list CRUD
│   └── about_screen.dart       # Name + Date
```

## 📦 Deliverables
✅ APK: AttendanceTasks_NipunaMadula_20250720.apk  
✅ GitHub Repo: [Your Repo Link]  
✅ README (this file)  
✅ (Optional) Hosted Web Link  
✅ (Optional) Demo Video  

## ⏱️ Time Taken
Approx: 2–4 hours

## 🙋 Author
**Name:** Nipuna Madula  
**Date Submitted:** 2025/07/20

---

**Thank you for reviewing my submission!**
