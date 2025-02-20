# Password Tracker Web App

A **secure** and **user-friendly** web application for storing and managing passwords. This project consists of a **Flutter frontend** and a **Spring Boot backend** with **MongoDB** as the database.

---

## 🚀 Features
- **User Authentication** (Register/Login with encrypted passwords)
- **Password Storage & Management** (Planned)
- **Password Strength Assessment** (Planned)
- **Integration with Password Breach Databases** (Planned)
- **Secure API with Spring Security & CORS Handling**

---

## 📂 Project Structure
```
password-tracker/
│── backend/         # Spring Boot Backend (Java, MongoDB)
│── frontend/        # Flutter Frontend (Flutter Web)
│── README.md        # Project-level Documentation
```

- **Backend (`backend/`)** → Manages authentication, password storage, and API logic.
- **Frontend (`frontend/`)** → Flutter-based UI with Provider state management.
- **MongoDB** → Stores user data and passwords.

---

## 🛠️ Tech Stack
| Component   | Technology |
|------------|-----------|
| **Frontend**   | Flutter Web (Dart) |
| **Backend**    | Spring Boot (Java) |
| **Database**   | MongoDB |
| **State Management** | Provider (Flutter) |
| **Security** | Spring Security (BCrypt) |
| **API Testing** | Postman |

---

## 🏗️ Setup Instructions

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/yourusername/password-tracker.git
cd password-tracker
```

### 2️⃣ Backend Setup
1. **Navigate to the backend directory**
   ```bash
   cd backend
   ```
2. **Ensure Java & Maven are installed**
   ```bash
   java -version
   mvn -version
   ```
3. **Start MongoDB**
   ```bash
   mongod --dbpath="C:\data\db"
   ```
   _(Alternatively, use Docker)_
   ```bash
   docker run -d -p 27017:27017 --name mongodb mongo
   ```
4. **Run the backend**
   ```bash
   mvn spring-boot:run
   ```

### 3️⃣ Frontend Setup
1. **Navigate to the frontend directory**
   ```bash
   cd ../frontend
   ```
2. **Ensure Flutter is installed**
   ```bash
   flutter doctor
   ```
3. **Get dependencies**
   ```bash
   flutter pub get
   ```
4. **Run the frontend**
   ```bash
   flutter run -d chrome --web-port=8000
   ```

---

## 🔌 API Endpoints
### 🔹 **User Authentication**
| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/api/auth/register` | Register a new user |
| `POST` | `/api/auth/login` | Login user |

**Example Request for Registering a User**
```json
POST /api/auth/register
{
    "username": "testuser",
    "password": "securepassword"
}
```
**Example Response**
```json
{
    "message": "User registered successfully"
}
```

---

## 🎯 Next Steps
- ✅ Implement **Authentication (Done)**
- ⏳ Add **Password Storage Features**
- ⏳ Implement **Password Strength Assessment**
- ⏳ Integrate with **HaveIBeenPwned API**
- ⏳ Enhance **UI & Security Features**

---

## 📜 License
This project is licensed under the MIT License.

