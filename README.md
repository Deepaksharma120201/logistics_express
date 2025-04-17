
# 🚚 Logistics Express

A high-performance, real-time logistics and delivery management app designed for fast, reliable, and secure deliveries. Built using Flutter and Firebase, it enables users to request deliveries, publishers to manage rides, and both parties to track and manage logistics efficiently.

---

## 📱 Demo

<!-- Insert screenshots/gifs below -->
<p align="center">
  <img src="assets/screenshots/login_screen.png" width="250" />
  <img src="assets/screenshots/home_dashboard.png" width="250" />
  <img src="assets/screenshots/request_delivery.png" width="250" />
</p>

---

## 🔧 Tech Stack

| Tech | Description |
|------|-------------|
| [Flutter](https://flutter.dev) | Cross-platform UI toolkit |
| [Dart](https://dart.dev) | Programming language for Flutter |
| [Firebase](https://firebase.google.com) | Backend-as-a-service: Auth, Firestore, FCM, Storage |
| [Google Maps API](https://developers.google.com/maps) | Geolocation and live tracking |
| [Provider / Riverpod](https://pub.dev/packages/riverpod) | State management |
| [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging) | Push notifications |
| [Firebase Authentication](https://firebase.google.com/products/auth) | Secure auth with 2FA support |
| [Firebase Firestore](https://firebase.google.com/products/firestore) | Real-time NoSQL database |

---

## 🧩 Features

### 👤 User Management
- Registration, login, logout
- Email verification & password reset
- Two-factor authentication (2FA)

> _Image Placeholder:_  
> `assets/screenshots/user_registration.png`

---

### 📦 Delivery Request
- Request pickup & drop-off deliveries
- Add special instructions
- Cancel or update delivery requests

> _Image Placeholder:_  
> `assets/screenshots/request_delivery_form.png`

---

### 🚗 Ride Management (For Publishers)
- Create, update, cancel rides
- View ride and delivery histories
- Track assigned deliveries

> _Image Placeholder:_  
> `assets/screenshots/ride_management.png`

---

### 💳 Payment Integration
- Secure payments for deliveries
- Confirm and cancel payment flows
- Payment history per user

> _Image Placeholder:_  
> `assets/screenshots/payment_status.png`

---

### 📍 Real-time Tracking
- Live tracking with Google Maps
- Pickup/drop visualization
- Distance & ETA calculations

> _Image Placeholder:_  
> `assets/screenshots/live_tracking.png`

---

### 🔔 Notifications
- Real-time system alerts
- Delivery status changes
- Mark as read and retrieve history

> _Image Placeholder:_  
> `assets/screenshots/notifications.png`

---

## 🚀 Setup Instructions

### 🧱 Clone the Repository

```bash
git clone https://github.com/your-org/logistics_express.git
cd logistics_express
flutter pub get
```

---

### 🔐 Firebase Setup

Go to [Firebase Console](https://console.firebase.google.com) and create a project.

Enable:

- Authentication (Email/Password, Phone)
- Cloud Firestore
- Cloud Messaging
- Storage (optional)

Add Firebase config files:

- `google-services.json` → `android/app/`
- `GoogleService-Info.plist` → `ios/Runner/`

Example Firestore rules:

```js
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

---

### 🗺 Google Maps API Setup

Go to [Google Cloud Console](https://console.cloud.google.com)

Enable:

- Maps SDK for Android
- Maps SDK for iOS

Get your API key:

- **Android**: Add to `AndroidManifest.xml`

```xml
<meta-data
  android:name="com.google.android.geo.API_KEY"
  android:value="YOUR_API_KEY_HERE"/>
```

- **iOS**: Add to `AppDelegate.swift`

```swift
GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
```

---

### 🧰 Running the App

#### Android

```bash
flutter run
```

#### iOS

- Open in Xcode
- Ensure proper developer account linked
- Run on physical device or simulator

---

### ✅ Final Checklist

- [x] Firebase project configured
- [x] API keys added
- [x] Flutter packages installed
- [x] App runs on emulator/device
- [x] All necessary services enabled

---

## 🗂 Project Structure

```
logistics_express/
├── lib/
│   ├── main.dart                     
│   ├── models/                        
│   │   ├── user.dart
│   │   ├── ride.dart
│   │   ├── delivery_request.dart
│   │   └── ...
│   ├── screens/                       
│   │   ├── login/
│   │   ├── dashboard/
│   │   ├── delivery_request/
│   │   └── ...
│   ├── services/                      
│   │   ├── auth_service.dart
│   │   ├── delivery_service.dart
│   │   └── ...
│   ├── providers/                     
│   │   ├── auth_provider.dart
│   │   ├── delivery_provider.dart
│   │   └── ...
│   ├── utils/                         
│   │   ├── constants.dart
│   │   ├── validators.dart
│   │   └── ...
│
├── assets/
│   └── screenshots/                   
│       ├── login_screen.png
│       ├── request_delivery.png
│       ├── ride_dashboard.png
│       └── ...
│
├── pubspec.yaml                       
└── README.md

```                          
apk_section = """
---

## 📦 Download APK (Android Build)

You can download and install the latest APK of the app directly from the command line.

### ⬇️ Download via cURL or wget

```
# Using Command-line 
flutter build apk --release --split-per-abi

```

--- 
### 🤝 Contributing

We welcome contributions from the community!  
To contribute:

    1. Fork the repo  
    2. Create a feature branch: `git checkout -b feature/your-feature`  
    3. Commit your changes: `git commit -m "feat: your update"`  
    4. Push to GitHub: `git push origin feature/your-feature`  
    5. Open a pull request 🚀

---

## 📃 License

This project is licensed under the [MIT License](LICENSE).

---

## ✉️ Contact

Have questions or feedback?

- 📧 deepaksharma120201@gmail.com  
- 🌐 [github.com/Deepaksharma120201/logistics_express](https://github.com/Deepaksharma120201/logistics_express)
