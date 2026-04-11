# 🌤️ Weather App — Flutter Weather Application

A feature-rich, real-time weather application built with Flutter, supporting GPS-based auto location detection, 7-day forecast, weather history, dark/light theme, and persistent search history.

---

## ✨ Features

- 🌍 **GPS Auto Location** — Automatically detects current location using device GPS
- 🔍 **City Search** — Search weather for any location worldwide
- 🕓 **Search History** — Remembers previous searches using SharedPreferences
- 📅 **7-Day Forecast** — Current weather + next 7 days hourly forecast
- 📆 **7-Day History** — Past 7 days weather history
- 🌙 **Dark / Light Theme** — Toggle between dark and light mode
- 📱 **Responsive Design** — Optimized for all screen sizes
- ⚡ **Riverpod State Management** — Clean and scalable state management

---

## 🛠️ Built With

| Technology | Purpose |
|---|---|
| Flutter & Dart | Cross-platform mobile UI |
| WeatherAPI.com | Weather data (forecast & history) |
| Riverpod | State management & theme management |
| Geolocator | GPS device location detection |
| Geocoding | Convert coordinates to city name |
| SharedPreferences | Persist previous search history |
| HTTP | REST API calls |
| Google Fonts | Custom typography |
| Intl | Date & time formatting |

---

## 🔌 API Used

**WeatherAPI.com** — [weatherapi.com](https://www.weatherapi.com)

```
Base URL: http://api.weatherapi.com/v1

Endpoints:
├── /forecast.json  → current weather + next 7 days forecast
└── /history.json   → past 7 days weather history
```

---

## 📁 Project Structure

```
lib/
├── services/
│   └── weather_api_services.dart  # All API calls (forecast & history)
├── provider/
│   └── weather_provider.dart      # Riverpod state management
├── models/
│   └── weather_model.dart         # Weather data models
├── view/
│   ├── home_screen.dart           # Main weather screen
│   ├── search_screen.dart         # City search screen
│   └── history_screen.dart        # Past 7 days history
├── widget/
│   ├── forecast_card.dart         # 7-day forecast card
│   └── hourly_card.dart           # Hourly weather card
└── main.dart
```

---

## 💡 Technical Highlights

- **Riverpod** — Used for both weather state and dark/light theme management
- **Geolocator + Geocoding** — GPS coordinates → city name → weather fetch
- **SharedPreferences** — Search history persisted across app sessions
- **REST API** — Two separate endpoints for forecast and history data
- **Loop for history** — Fetches past 7 days individually by iterating dates
- **Error handling** — API error responses caught and displayed to user
- **`containsKey('error')`** — Safe JSON error detection from WeatherAPI response
- **`padLeft(2, '0')`** — Proper date formatting for API date parameters

---

## 🚀 Setup & Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/sudipta200024/weathermobileapp.git
   cd weathermobileapp
   ```

2. **Get API Key**
   - Create a free account at [weatherapi.com](https://www.weatherapi.com)
   - Copy your API key from the dashboard
   - Replace in `weather_api_services.dart`:
   ```dart
   const String apiKey = "YOUR_API_KEY_HERE";
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 📱 Permissions Required

Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

---

## 🎬 Demo

[📹 Watch Demo Video](https://www.linkedin.com/posts/sudipta-das2025_flutter-riverpod-flutterdev-ugcPost-7422197095195074560-M9Te)
---

## 👨‍💻 Author

**Sudipta Das**
Flutter App Developer

📧 sudiptadas200024@gmail.com
🔗 [LinkedIn](https://linkedin.com/in/sudipta-das2025)
🌐 [GitHub](https://github.com/sudipta200024)
