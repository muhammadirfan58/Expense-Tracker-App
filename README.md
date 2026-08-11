# 📱 Expense Tracker App

A modern, responsive, and robust **Flutter Expense Tracker Application** designed to help users track and manage their daily expenses effortlessly. It supports local persistent storage on mobile devices and a temporary in-memory database fallback for seamless web and desktop browser previews.

---

## ✨ Features

- **Add Expense**: Enter title, amount, select category (Food, Transport, Bills, Shopping, Entertainment, Other), and choose date using a built-in date picker.
- **Expense Card View**: Clear layout displaying the expense title, category, date, amount, and an easy delete button.
- **Total Expense Banner**: Automatically calculates and displays the sum of all recorded expenses in real-time.
- **Dynamic Platform Adaptability**: 
  - **Mobile (Android/iOS)**: Uses SQLite database via `sqflite` for persistent local storage.
  - **Web (Chrome) & Desktop**: Automatically falls back to a temporary in-memory storage if SQLite is unsupported, preventing crashes and allowing instant web testing.
- **Robust Error Handling**: Operations are wrapped in `try-catch` blocks with visual SnackBar notifications for any runtime errors.
- **Clean Styling**: Standardized alignments and Material 3 seed color design.

---

## 🛠️ Tech Stack & Architecture

- **Frontend**: [Flutter SDK](https://flutter.dev) (Dart)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Database**: [sqflite](https://pub.dev/packages/sqflite) (SQLite for mobile)
- **Design System**: Material Design 3

---

## 🚀 Getting Started

### Prerequisites

Make sure you have Flutter installed on your machine. You can verify it by running:
```bash
flutter doctor
```

### Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/muhammadirfan58/Expense-Tracker-App.git
   cd Expense-Tracker-App
   ```

2. **Get Dependencies**:
   ```bash
   flutter pub get
   ```

### Running the App

- **Run in Chrome (Web)**:
  ```bash
   flutter run -d chrome
   ```
- **Run in Mobile Emulator/Device**:
  ```bash
   flutter run
   ```

### Running Tests

To run the unit/widget test suite:
```bash
flutter test
```
