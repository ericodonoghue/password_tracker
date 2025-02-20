# 📡 Password Tracker Backend

This is the backend for the **Password Tracker Web App**, built using **Spring Boot** and **MongoDB**.

---

## 🚀 Features
- **User Authentication** (Register/Login with encrypted passwords)
- **Spring Security for Secure API Calls**
- **MongoDB for Persistent Data Storage**
- **CORS Configuration for Flutter Frontend**
- **REST API for User Management**

---

## 🛠️ Tech Stack
| Component   | Technology |
|------------|-----------|
| **Backend**    | Spring Boot (Java) |
| **Database**   | MongoDB |
| **Security** | Spring Security (BCrypt) |
| **Build Tool** | Maven |
| **API Testing** | Postman |

---

## 🏗️ Setup Instructions

### 1️⃣ Install Prerequisites
- **Java 17+**
- **Maven**
- **MongoDB**

### 2️⃣ Clone the Repository
```bash
git clone https://github.com/yourusername/password-tracker.git
cd password-tracker/backend
```

### 3️⃣ Configure MongoDB
- Start MongoDB locally:
  ```bash
  mongod --dbpath="path to data directory"
  ```
  _(Alternatively, use Docker)_
  ```bash
  docker run -d -p 27017:27017 --name mongodb mongo
  ```
- Check if MongoDB is running using **MongoDB Compass** or:
  ```bash
  mongo
  show dbs
  ```

### 4️⃣ Run the Backend
```bash
mvn spring-boot:run
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

## 🔐 Security Configuration
This backend uses **Spring Security**:
- Passwords are **hashed using BCrypt**.
- Security rules are configured in `SecurityConfig.java`.
- CORS is enabled in `CorsConfig.java` to allow frontend requests:
```java
registry.addMapping("/api/**")
        .allowedOrigins("http://localhost:8000")
        .allowedMethods("GET", "POST", "PUT", "DELETE");
```

---

## 🔍 Testing with Postman
1. **Start the backend** (`mvn spring-boot:run`).
2. Open **Postman**.
3. Test the register/login API with:
   ```json
   POST http://localhost:8080/api/auth/register
   {
       "username": "testuser",
       "password": "securepassword"
   }
   ```
4. If successful, check MongoDB Compass to see the user stored in the database.

---

## 🎯 Next Steps
- ✅ Implement **Authentication (Done)**
- ⏳ Add **Password Storage Features**
- ⏳ Implement **Password Strength Assessment**
- ⏳ Integrate with **HaveIBeenPwned API**
- ⏳ Improve API Security (JWT-based authentication)

---

## 📜 License
This project is licensed under the MIT License.

