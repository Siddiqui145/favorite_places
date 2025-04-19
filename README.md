# 📍 Favorite Places – Flutter App

Favorite Places is a modern Flutter application that allows users to save and manage custom locations along with photos and metadata. The app uses native device capabilities, Google Maps integration, and local data persistence to deliver a smooth offline-first experience.

---

## ✨ Features

- 🖼 Select an image using the device **camera**
- 🌍 Get **current GPS location** or pick from **Google Maps**
- 🗺 Display a **static map preview**
- 🔄 Perform **reverse geocoding** to get a human-readable address
- 🧠 State management with **Riverpod**
- 💾 Store places **locally with SQLite**
- 📱 Fully responsive and compatible with both Android & iOS

---

## 🛠 Tech Stack

| Tech           | Description                         |
|----------------|-------------------------------------|
| Flutter        | Mobile SDK for cross-platform apps  |
| Riverpod       | State management                   |
| google_maps_flutter | Interactive Google Maps widget |
| location       | Native device location access       |
| http           | REST API calls to Google APIs       |
| image_picker   | Access device camera/gallery        |

---

## 📸 App Demo

https://github.com/user-attachments/assets/32cd5f57-0b1b-4716-8df3-0b705143c542

---

## 📂 Directory Structure

```
lib/
├── main.dart
├── models/
│   └── place_model.dart
├── providers/
│   └── places_provider.dart
├── screens/
│   ├── add_place_screen.dart
│   └── places_list_screen.dart
├── widgets/
│   ├── image_input_widget.dart
│   ├── location_input_widget.dart
│   └── places_list_widget.dart

```

---

## 🔐 API Setup

This app uses **Google Maps API**. To run the app:

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a project and enable the following APIs:
   - Maps Static API
   - Maps SDK for Android/iOS
   - Geocoding API
3. Create an API key and replace it inside:
   ```
   lib/secrets/api_key.dart
   ```

```dart
const String apiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
```

> ⚠️ **DO NOT COMMIT your API keys** to public repositories!

---

## 💾 Local Database

The app uses `sqflite` for persistent storage. On first run, the app initializes a `places.db` and stores each place with:

- ID
- Title
- Image path
- Location (lat/lng + address)

---

## 🧪 Getting Started

### 🔧 Setup

```bash
flutter pub get
```

### ▶️ Run

```bash
flutter run
```

---

## 📱 Permissions

Make sure you’ve added necessary permissions in:

- `AndroidManifest.xml`:
  ```xml
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
  <uses-permission android:name="android.permission.CAMERA"/>
  ```

- `Info.plist` (iOS):
  ```xml
  <key>NSCameraUsageDescription</key>
  <string>Camera access to take pictures</string>
  <key>NSLocationWhenInUseUsageDescription</key>
  <string>Location access to get your current location</string>
  ```

---

## 🧑‍💻 Contributions

Feel free to open issues or submit pull requests. Contributions are always welcome!

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
