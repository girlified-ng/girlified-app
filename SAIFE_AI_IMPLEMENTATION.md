# Girlified Mobile App - Implementation Guide

## 🛡️ Overview

Girlified is a digital bodyguard mobile application designed to protect women and girls from harmful content on social media platforms. The app uses on-device AI to detect and filter harmful/violent content in real-time on TikTok, Instagram, and YouTube.

**Website**: https://saifeai.girlified.com.ng

## 🎨 Design System

- **Primary Color**: Electric Lilac (#8B5CF6)
- **Secondary Color**: Teal (#14B8A6)
- **Background**: Dark Mode (#1A1625)
- **Card Background**: #2D2640

## 📱 App Architecture

### Navigation Structure (3 Screens)

1. **Protection Dashboard** - Main screen with protection toggle and real-time stats
2. **Activity** - History of blocked content and statistics
3. **Settings** - App configuration and permissions management

### Core Components

#### 1. Flutter Layer (UI & Logic)

**Screens:**
- `lib/presentation/dashboard/protection_dashboard_screen.dart` - Main protection interface
- `lib/presentation/dashboard/activity_screen.dart` - Blocked content history
- `lib/presentation/dashboard/settings_screen.dart` - App settings
- `lib/presentation/onboarding/permission_onboarding_screen.dart` - First-time setup

**Services:**
- `lib/data/services/tflite_service.dart` - TensorFlow Lite integration for AI inference
- `lib/data/services/protection_service.dart` - Background monitoring service
- `lib/data/services/native_service.dart` - Bridge to native Android code

**Updated Files:**
- `lib/presentation/dashboard/dashboard.dart` - Updated to use 3 screens
- `lib/components/navigation/custom_bottom_navigation.dart` - Updated navigation
- `lib/core/constants/colors.dart` - Updated with Girlified branding

#### 2. Native Android Layer

**Kotlin Files:**
- `android/app/src/main/kotlin/com/girlified/girlified/SaifeAccessibilityService.kt` - Accessibility service for monitoring apps
- `android/app/src/main/kotlin/com/girlified/girlified/OverlayService.kt` - Blur overlay implementation
- `android/app/src/main/kotlin/com/girlified/girlified/NativeMethodChannel.kt` - Flutter-Native communication
- `android/app/src/main/kotlin/com/girlified/girlified/MainActivity.kt` - Updated main activity

**Configuration:**
- `android/app/src/main/res/xml/accessibility_service_config.xml` - Accessibility service config
- `android/app/src/main/res/values/strings.xml` - App strings
- `android/app/src/main/AndroidManifest.xml` - Updated with permissions and services

## 🔧 Technical Implementation

### 1. Android Accessibility Service

The accessibility service monitors target apps (TikTok, Instagram, YouTube) for content changes:

```kotlin
// Monitors these package names
val targetApps = setOf(
    "com.zhiliaoapp.musically",      // TikTok
    "com.instagram.android",         // Instagram
    "com.google.android.youtube"     // YouTube
)
```

**How it works:**
1. Listens for `TYPE_WINDOW_CONTENT_CHANGED` and `TYPE_VIEW_SCROLLED` events
2. Extracts text content from the screen
3. Analyzes content using TFLite model or keyword detection
4. Shows blur overlay if harmful content is detected

### 2. System Alert Window (Overlay)

The overlay appears when harmful content is detected:

**Features:**
- Full-screen blur effect
- Shield icon with warning message
- Two action buttons:
  - "Scroll Away" - Dismisses overlay and navigates back
  - "Reveal Content" - Dismisses overlay and shows content

**Permissions Required:**
- `SYSTEM_ALERT_WINDOW` - To draw over other apps
- `TYPE_APPLICATION_OVERLAY` - For Android O and above

### 3. TensorFlow Lite Integration

**Model Requirements:**
- Input: 224x224 RGB image
- Output: 6 categories (Safe, Violence, Explicit, Harassment, Hate Speech, Self-Harm)
- Format: `.tflite` model file

**Location:** `assets/models/harmful_content_detector.tflite`

**Note:** Currently uses fallback keyword detection. You need to train and add your own TFLite model.

### 4. Privacy-First Architecture

✅ All processing happens on-device
✅ No screenshots leave the device
✅ No data sent to external servers
✅ TensorFlow Lite runs locally
✅ No cloud dependencies for core functionality

## 📦 Dependencies Added

```yaml
dependencies:
  tflite_flutter: ^0.10.4                    # TensorFlow Lite
  tflite_flutter_helper: ^0.3.1             # TFLite helpers
  image: ^4.0.17                             # Image processing
  flutter_background_service: ^5.0.5         # Background service
  flutter_local_notifications: ^18.0.1       # Notifications
  shared_preferences: ^2.3.3                 # Local storage
  sqflite: ^2.4.1                           # Database
  permission_handler: ^11.4.0                # Permissions (existing)
  flutter_animate: ^4.2.0+1                 # Animations (existing)
```

## 🚀 Setup Instructions

### Step 1: Install Dependencies

```bash
flutter pub get
```

### Step 2: Add TFLite Model (Important!)

1. Create directory: `assets/models/`
2. Add your trained TFLite model: `harmful_content_detector.tflite`
3. Update `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/models/
```

**Training the Model:**
- Use a dataset of harmful vs safe content
- Categories: Safe, Violence, Explicit Content, Harassment, Hate Speech, Self-Harm
- Input size: 224x224 RGB
- Export as TFLite format
- Recommended: Use TensorFlow or PyTorch with TFLite converter

### Step 3: Build Android App

```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### Step 4: Test on Device

```bash
flutter run --release
```

**Note:** Accessibility services only work on physical devices, not emulators.

## 🔐 Required Permissions

### Android Manifest Permissions

All required permissions have been added to `AndroidManifest.xml`:

1. **SYSTEM_ALERT_WINDOW** - Draw overlay
2. **BIND_ACCESSIBILITY_SERVICE** - Accessibility service
3. **FOREGROUND_SERVICE** - Background monitoring
4. **POST_NOTIFICATIONS** - Alert notifications
5. **INTERNET** - For future cloud features (optional)
6. **ACCESS_NETWORK_STATE** - Network status

### Runtime Permissions

Users must grant these during onboarding:

1. **Accessibility Service** - Enable in Settings > Accessibility
2. **Display Over Other Apps** - Enable in Settings > Special app access
3. **Notifications** - Standard runtime permission

## 🎯 Key Features Implemented

### ✅ Protection Dashboard
- Animated shield with pulse effect
- Real-time protection toggle
- Statistics (blocked content count, scans)
- Safety sensitivity slider (Low/Medium/High)
- Protected apps list

### ✅ Activity Screen
- Blocked content history with tabs
- Statistics breakdown by app and content type
- Filter options
- Visual charts and progress indicators

### ✅ Settings Screen
- Permission management
- Protected apps configuration
- Content categories selection
- Privacy information
- App version and support

### ✅ Onboarding Flow
- 4-page introduction
- Permission setup wizard
- Step-by-step guidance
- Visual feedback for granted permissions

### ✅ Native Integration
- Accessibility Service implementation
- Blur overlay with custom UI
- Method channel for Flutter-Native communication
- Event streaming for real-time updates

## 🔄 How It Works (Flow)

1. **User Opens App** → Onboarding (first time) or Dashboard
2. **User Enables Protection** → Accessibility service starts monitoring
3. **User Opens TikTok/Instagram/YouTube** → Service detects app launch
4. **Content Appears** → Service captures screen content
5. **AI Analysis** → TFLite model analyzes for harmful content
6. **If Harmful** → Blur overlay appears with options
7. **User Choice**:
   - Scroll Away → Navigates back, content blocked
   - Reveal Content → Overlay dismissed, content shown
8. **Logging** → Event saved to history, stats updated
9. **Notification** → User notified of blocked content

## 🧪 Testing Checklist

### Functionality Tests
- [ ] Onboarding flow completes successfully
- [ ] Permissions can be granted
- [ ] Protection toggle works
- [ ] Sensitivity slider updates
- [ ] Activity screen shows data
- [ ] Settings save properly
- [ ] Navigation between screens works

### Native Integration Tests
- [ ] Accessibility service can be enabled
- [ ] Service detects target apps
- [ ] Overlay appears and dismisses
- [ ] Method channel communication works
- [ ] Events stream to Flutter

### Performance Tests
- [ ] App runs smoothly with service active
- [ ] Battery usage is acceptable
- [ ] Memory usage is reasonable
- [ ] No lag when scrolling in target apps

## 🐛 Known Limitations & TODOs

### Current Limitations
1. **No TFLite Model Included** - You must train and add your own model
2. **Keyword-Based Fallback** - Uses simple keyword matching without model
3. **Limited to 3 Apps** - Currently monitors TikTok, Instagram, YouTube only
4. **No Database** - History stored in SharedPreferences (not scalable)
5. **No Cloud Sync** - All data is local only

### Future Enhancements
- [ ] Train and integrate production TFLite model
- [ ] Add SQLite database for history
- [ ] Implement more sophisticated NLP for text analysis
- [ ] Add user accounts and cloud backup (optional)
- [ ] Support more social media apps
- [ ] Add parental controls
- [ ] Implement ML model updates
- [ ] Add content reporting feature
- [ ] Create admin dashboard for insights

## 📚 Additional Resources

### TensorFlow Lite
- [TFLite Flutter Plugin](https://pub.dev/packages/tflite_flutter)
- [TFLite Model Maker](https://www.tensorflow.org/lite/models/modify/model_maker)
- [Image Classification Tutorial](https://www.tensorflow.org/lite/examples/image_classification/overview)

### Android Accessibility
- [Accessibility Service Guide](https://developer.android.com/guide/topics/ui/accessibility/service)
- [System Alert Window](https://developer.android.com/reference/android/Manifest.permission#SYSTEM_ALERT_WINDOW)

### Flutter Background Services
- [flutter_background_service](https://pub.dev/packages/flutter_background_service)
- [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)

## 🤝 Support

For issues or questions:
- Email: support@girlified.com.ng
- Website: https://saifeai.girlified.com.ng

## 📄 License

This implementation is part of the Girlified project for women's safety.

---

**Built with ❤️ for women's safety and digital wellbeing**



