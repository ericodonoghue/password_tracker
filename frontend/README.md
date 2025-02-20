# 🖥️ Password Tracker Frontend (Flutter Web)

This is the **Flutter Web frontend** for the Password Tracker App.

---

## 🚀 Features
- **User Authentication (Login/Register)**
- **State Management with Provider**
- **Secure API Calls to Spring Boot Backend**
- **Responsive UI for Password Management**

---

## 🛠️ Tech Stack
| Component   | Technology |
|------------|-----------|
| **Frontend**   | Flutter Web (Dart) |
| **State Management** | Provider (Flutter) |
| **HTTP Client** | `http` package |
| **UI Framework** | Material Design |

---

## 🏗️ Setup Instructions

### 1️⃣ Install Flutter
- Download and install **Flutter SDK** from [Flutter.dev](https://flutter.dev/docs/get-started/install).
- Enable **Flutter Web**:
```bash
flutter config --enable-web
```
- Verify installation:
```bash
flutter doctor
```

### 2️⃣ Clone the Repository
```bash
git clone https://github.com/yourusername/password-tracker.git
cd password-tracker/frontend
```

### 3️⃣ Install Dependencies
```bash
flutter pub get
```

### 4️⃣ Run the App
```bash
flutter run -d chrome --web-port=8000
```
- The app will open in **Google Chrome**.

---

## 📂 Project Structure
```
frontend/
│── lib/
│   │── main.dart          # Entry Point
│   │── screens/
│   │   │── login_screen.dart
│   │   │── home_screen.dart
│   │── providers/
│   │   │── auth_provider.dart
│   └── widgets/
│── pubspec.yaml           # Dependencies
```

---

## 🔌 API Communication
The **AuthProvider** class handles API calls.

📌 **`auth_provider.dart`**
```dart
Future<bool> login(String username, String password) async {
    final response = await http.post(
        Uri.parse('http://localhost:8080/api/auth/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
    );

    return response.statusCode == 200;
}
```

---

## 📌 Navigation Flow
1️⃣ User logs in.  
2️⃣ On success, navigates to **Home Screen** (`/home`).  
3️⃣ If login fails, error message is displayed.

📌 **`login_screen.dart`**
```dart
if (success) {
    Navigator.pushReplacementNamed(context, '/home');
} else {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Authentication failed"))
    );
}
```

---

## 🎯 Next Steps
- ⏳ Add **Password Entry UI**
- ⏳ Implement **Dark Mode**
- ⏳ Improve **Form Validation**

---

## 📜 License
This project is licensed under the MIT License.

