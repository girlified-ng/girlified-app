# 🛡️ Girlified - Digital Bodyguard for Women & Girls

<div align="center">

![Girlified](https://img.shields.io/badge/Saife%20AI-Digital%20Bodyguard-8B5CF6?style=for-the-badge)
![Flutter](https://img.shields.io/badge/Flutter-3.5.3-02569B?style=for-the-badge&logo=flutter)
![Android](https://img.shields.io/badge/Android-24%2B-3DDC84?style=for-the-badge&logo=android)
![License](https://img.shields.io/badge/License-Proprietary-red?style=for-the-badge)

**A mobile application that protects women and girls from harmful content on social media using on-device AI.**

[Website](https://saifeai.girlified.com.ng) • [Documentation](#-documentation) • [Quick Start](#-quick-start) • [Support](#-support)

</div>

---

## 🌟 Overview

Girlified is a **digital bodyguard** that runs in the background and uses on-device AI to detect and filter harmful/violent content on social media apps (TikTok, Instagram, YouTube) in real-time. All processing happens locally on the device - no data is ever sent to external servers.

### Key Features

- 🛡️ **Real-Time Protection** - Monitors social media apps as you use them
- 🤖 **On-Device AI** - TensorFlow Lite for privacy-first content analysis
- 🚫 **Instant Blocking** - Blur overlay appears when harmful content is detected
- 📊 **Activity Tracking** - See what content was blocked and when
- ⚙️ **Customizable** - Adjust sensitivity levels to your preference
- 🔒 **Privacy First** - All processing happens on your device
- 🎨 **Beautiful UI** - Modern dark theme with smooth animations

---

## 🎨 Screenshots

### Protection Dashboard
<div align="center">
  <img src="screenshots/dashboard.png" width="250" alt="Dashboard" />
  <p><i>Main protection screen with animated shield and real-time stats</i></p>
</div>

### Activity Screen
<div align="center">
  <img src="screenshots/activity.png" width="250" alt="Activity" />
  <p><i>Blocked content history and statistics</i></p>
</div>

### Settings
<div align="center">
  <img src="screenshots/settings.png" width="250" alt="Settings" />
  <p><i>Permissions, preferences, and app configuration</i></p>
</div>

---

## 🚀 Quick Start

### Prerequisites

- Flutter SDK 3.5.3 or higher
- Android Studio or VS Code
- Physical Android device (API 24+)
- Basic knowledge of Flutter and Kotlin

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/saife-ai-app.git
   cd saife-ai-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Add TFLite Model** ⚠️ **CRITICAL**
   - Train or obtain a TFLite model for harmful content detection
   - Place it at: `assets/models/harmful_content_detector.tflite`
   - See [Model Training Guide](assets/models/README.md)

4. **Run the app**
   ```bash
   flutter run
   ```

5. **Enable permissions**
   - Settings → Accessibility → Girlified → Enable
   - Settings → Display over other apps → Girlified → Allow

For detailed setup instructions, see [QUICK_START.md](QUICK_START.md).

---

## 📚 Documentation

### Getting Started
- **[Quick Start Guide](QUICK_START.md)** - Get up and running in 5 minutes
- **[Implementation Summary](IMPLEMENTATION_SUMMARY.md)** - What was built and why

### Technical Documentation
- **[Implementation Guide](SAIFE_AI_IMPLEMENTATION.md)** - Complete technical details
- **[Architecture](ARCHITECTURE.md)** - System design and data flow
- **[Directory Structure](DIRECTORY_STRUCTURE.md)** - Project organization

### Development
- **[Model Training Guide](assets/models/README.md)** - Train your TFLite model
- **[Deployment Checklist](DEPLOYMENT_CHECKLIST.md)** - Pre-launch checklist

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────┐
│         Flutter UI Layer                │
│  (Dashboard, Activity, Settings)        │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│         Service Layer                   │
│  (TFLite, Protection, Native Bridge)    │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│         Native Android Layer            │
│  (Accessibility Service, Overlay)       │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│         Target Apps                     │
│  (TikTok, Instagram, YouTube)           │
└─────────────────────────────────────────┘
```

See [ARCHITECTURE.md](ARCHITECTURE.md) for detailed diagrams.

---

## 🔧 Technology Stack

### Frontend
- **Flutter 3.5.3** - Cross-platform UI framework
- **GetX** - State management
- **Flutter Animate** - Smooth animations

### AI/ML
- **TensorFlow Lite** - On-device machine learning
- **Image Processing** - Content analysis
- **NLP** - Text analysis

### Native Android
- **Kotlin** - Native Android development
- **Accessibility Service** - Screen monitoring
- **System Alert Window** - Blur overlay

### Storage
- **SharedPreferences** - Settings and stats
- **SQLite** (planned) - History database

---

## 🎯 How It Works

1. **User enables protection** in the app
2. **Accessibility service** monitors target apps (TikTok, Instagram, YouTube)
3. **Content is analyzed** using on-device TFLite model
4. **If harmful content detected**, blur overlay appears instantly
5. **User chooses** to scroll away or reveal content
6. **Event is logged** and statistics are updated

All processing happens **on-device**. No data leaves your phone.

---

## 🔐 Privacy & Security

### Privacy First
✅ All AI processing on-device  
✅ No screenshots sent to servers  
✅ No cloud dependencies  
✅ User data stays on device  
✅ Transparent permissions  

### Security
✅ Secure local storage  
✅ Permission-based access  
✅ No external data transmission  
✅ Code obfuscation enabled  

---

## 📱 Supported Platforms

### Android
- ✅ Android 7.0+ (API 24+)
- ✅ Tested on Android 13
- ✅ Works on all screen sizes

### iOS
- ⚠️ Not currently supported
- iOS has stricter limitations on accessibility and screen monitoring
- Future support may be limited

---

## 🛠️ Development

### Project Structure

```
lib/
├── presentation/
│   ├── dashboard/
│   │   ├── protection_dashboard_screen.dart
│   │   ├── activity_screen.dart
│   │   └── settings_screen.dart
│   └── onboarding/
│       └── permission_onboarding_screen.dart
├── data/
│   └── services/
│       ├── tflite_service.dart
│       ├── protection_service.dart
│       └── native_service.dart
└── core/
    └── constants/
        └── colors.dart

android/
└── app/src/main/kotlin/
    └── com/girlified/girlified/
        ├── SaifeAccessibilityService.kt
        ├── OverlayService.kt
        └── NativeMethodChannel.kt
```

See [DIRECTORY_STRUCTURE.md](DIRECTORY_STRUCTURE.md) for complete structure.

### Building

```bash
# Debug build
flutter run

# Release APK
flutter build apk --release

# Release App Bundle
flutter build appbundle --release
```

### Testing

```bash
# Run tests
flutter test

# Check for issues
flutter analyze

# Format code
flutter format .
```

---

## 🤝 Contributing

This is a private project for women's safety. If you'd like to contribute or have suggestions, please contact us at support@girlified.com.ng.

---

## 📊 Roadmap

### Current Version (1.0.0)
- ✅ Core protection features
- ✅ 3 social media apps supported
- ✅ On-device AI infrastructure
- ✅ Beautiful UI with dark theme
- ⚠️ TFLite model (to be added)

### Planned Features
- [ ] Production ML model
- [ ] More social media apps
- [ ] SQLite database
- [ ] Parental controls
- [ ] Cloud sync (optional)
- [ ] iOS support (limited)
- [ ] Multi-language support
- [ ] Content reporting

---

## ⚠️ Important Notes

### Critical Requirements

1. **TFLite Model Required** ⚠️
   - The app uses keyword-based fallback detection without a model
   - This is NOT suitable for production
   - You must train and add a proper TFLite model
   - See [Model Training Guide](assets/models/README.md)

2. **Physical Device Required**
   - Accessibility services don't work on emulators
   - Must test on real Android device

3. **Manual Permission Setup**
   - Users must manually enable accessibility service
   - Cannot be automated due to Android security

---

## 🐛 Known Issues

- [ ] TFLite model not included (must be added)
- [ ] History stored in SharedPreferences (not scalable)
- [ ] Limited to 3 apps (TikTok, Instagram, YouTube)
- [ ] Android only (iOS not supported)

See [Issues](https://github.com/yourusername/saife-ai-app/issues) for full list.

---

## 📄 License

This project is proprietary software owned by Girlified. All rights reserved.

For licensing inquiries, contact: support@girlified.com.ng

---

## 🙏 Acknowledgments

- **Flutter Team** - Amazing framework
- **TensorFlow Team** - TFLite for mobile ML
- **Women's Safety Advocates** - Inspiration and guidance
- **Beta Testers** - Valuable feedback

---

## 📞 Support

### Get Help
- 📧 Email: support@girlified.com.ng
- 🌐 Website: https://saifeai.girlified.com.ng
- 📚 Documentation: See [docs](#-documentation)

### Report Issues
- 🐛 Bug Reports: support@girlified.com.ng
- 💡 Feature Requests: support@girlified.com.ng
- 🔒 Security Issues: security@girlified.com.ng

---

## 💖 Mission

Girlified is built with a mission to **protect women and girls** from harmful content online. We believe technology should empower and protect, not harm.

Every line of code in this project is written with the goal of making the digital world safer for vulnerable users.

---

<div align="center">

**Built with ❤️ for women's safety and digital wellbeing**

[Website](https://saifeai.girlified.com.ng) • [Documentation](#-documentation) • [Support](#-support)

---

© 2024 Girlified. All rights reserved.

</div>
