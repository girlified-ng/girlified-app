# Girlified - Project Directory Structure

## 📁 Complete Directory Layout

```
saife-ai-app/
│
├── android/                                    # Android native code
│   └── app/
│       └── src/
│           └── main/
│               ├── kotlin/com/girlified/girlified/
│               │   ├── MainActivity.kt                      # ✨ Updated with method channel
│               │   ├── SaifeAccessibilityService.kt        # ✨ NEW - Accessibility service
│               │   ├── OverlayService.kt                   # ✨ NEW - Blur overlay
│               │   └── NativeMethodChannel.kt              # ✨ NEW - Flutter bridge
│               ├── res/
│               │   ├── xml/
│               │   │   └── accessibility_service_config.xml # ✨ NEW - Service config
│               │   └── values/
│               │       └── strings.xml                      # ✨ NEW - App strings
│               └── AndroidManifest.xml                      # ✨ Updated with permissions
│
├── lib/                                        # Flutter/Dart code
│   ├── components/
│   │   ├── navigation/
│   │   │   └── custom_bottom_navigation.dart              # ✨ Updated - 3 tabs
│   │   └── [other existing components]
│   │
│   ├── core/
│   │   ├── constants/
│   │   │   ├── colors.dart                                # ✨ Updated - Girlified colors
│   │   │   ├── routes.dart
│   │   │   └── secrets.dart
│   │   └── [other core files]
│   │
│   ├── data/
│   │   ├── services/
│   │   │   ├── tflite_service.dart                        # ✨ NEW - AI model integration
│   │   │   ├── protection_service.dart                    # ✨ NEW - Background service
│   │   │   └── native_service.dart                        # ✨ NEW - Native bridge
│   │   └── repositories/
│   │       └── [existing repositories]
│   │
│   ├── presentation/
│   │   ├── dashboard/
│   │   │   ├── dashboard.dart                             # ✨ Updated - 3 screens
│   │   │   ├── protection_dashboard_screen.dart           # ✨ NEW - Main screen
│   │   │   ├── activity_screen.dart                       # ✨ NEW - History screen
│   │   │   ├── settings_screen.dart                       # ✨ NEW - Settings screen
│   │   │   ├── home_screen.dart                           # ⚠️ Old - can be removed
│   │   │   ├── cycle_screen.dart                          # ⚠️ Old - can be removed
│   │   │   ├── scan_screen.dart                           # ⚠️ Old - can be removed
│   │   │   ├── results_screen.dart                        # ⚠️ Old - can be removed
│   │   │   └── profile_screen.dart                        # ⚠️ Old - can be removed
│   │   ├── onboarding/
│   │   │   └── permission_onboarding_screen.dart          # ✨ NEW - Onboarding flow
│   │   └── [other presentation folders]
│   │
│   └── main.dart                                          # Main entry point
│
├── assets/                                     # Asset files
│   ├── icons/                                 # App icons
│   ├── fonts/                                 # Custom fonts
│   └── models/                                # ✨ NEW - TFLite models
│       └── harmful_content_detector.tflite    # ⚠️ TODO: Add your model here
│
├── pubspec.yaml                               # ✨ Updated - New dependencies
├── SAIFE_AI_IMPLEMENTATION.md                 # ✨ NEW - Implementation guide
└── DIRECTORY_STRUCTURE.md                     # ✨ NEW - This file

```

## 🔑 Legend

- ✨ **NEW** - Newly created file for Girlified
- ✨ **Updated** - Existing file modified for Girlified
- ⚠️ **Old** - Old file that can be removed (optional)
- 📁 **Folder** - Directory

## 📝 File Descriptions

### New Flutter Screens

| File | Purpose | Key Features |
|------|---------|--------------|
| `protection_dashboard_screen.dart` | Main protection interface | Toggle, stats, sensitivity slider, protected apps |
| `activity_screen.dart` | Blocked content history | Tabs, filters, statistics, content breakdown |
| `settings_screen.dart` | App configuration | Permissions, categories, privacy, support |
| `permission_onboarding_screen.dart` | First-time setup | 4-page intro, permission wizard |

### New Services

| File | Purpose | Key Features |
|------|---------|--------------|
| `tflite_service.dart` | AI model integration | Image analysis, text analysis, TFLite inference |
| `protection_service.dart` | Background monitoring | Service management, notifications, statistics |
| `native_service.dart` | Flutter-Native bridge | Method channels, event streams, permission checks |

### New Native Files

| File | Purpose | Key Features |
|------|---------|--------------|
| `SaifeAccessibilityService.kt` | Accessibility service | Screen monitoring, content extraction, event handling |
| `OverlayService.kt` | Blur overlay | Full-screen overlay, action buttons, window management |
| `NativeMethodChannel.kt` | Communication bridge | Method handlers, event streaming, settings integration |

### Updated Files

| File | Changes Made |
|------|--------------|
| `colors.dart` | Added Electric Lilac (#8B5CF6) and Teal (#14B8A6) |
| `custom_bottom_navigation.dart` | Reduced to 3 tabs: Protection, Activity, Settings |
| `dashboard.dart` | Updated to use 3 new screens |
| `MainActivity.kt` | Added NativeMethodChannel initialization |
| `AndroidManifest.xml` | Added permissions and services |
| `pubspec.yaml` | Added TFLite and background service dependencies |

## 🗑️ Optional Cleanup

These old files are no longer used and can be removed:

```
lib/presentation/dashboard/
├── home_screen.dart       # Replaced by protection_dashboard_screen.dart
├── cycle_screen.dart      # No longer needed
├── scan_screen.dart       # No longer needed
├── results_screen.dart    # Replaced by activity_screen.dart
└── profile_screen.dart    # Merged into settings_screen.dart
```

**Note:** Keep them if you want to preserve the old functionality or revert changes.

## 📦 Assets to Add

### Required Assets

1. **TFLite Model** (Critical!)
   - Path: `assets/models/harmful_content_detector.tflite`
   - Status: ⚠️ **NOT INCLUDED** - You must train and add this
   - Input: 224x224 RGB image
   - Output: 6 categories

2. **App Icon** (Optional - Update if needed)
   - Path: `assets/logo.jpg`
   - Update with Girlified branding

3. **Fonts** (Already included)
   - Inter
   - SF Pro

## 🔧 Configuration Files

### Android Configuration

```
android/app/src/main/
├── AndroidManifest.xml           # Permissions, services declared
├── res/
│   ├── xml/
│   │   └── accessibility_service_config.xml  # Service configuration
│   └── values/
│       └── strings.xml           # App name, descriptions
```

### Flutter Configuration

```
pubspec.yaml                      # Dependencies, assets
.env                             # Environment variables (if any)
```

## 🚀 Build Outputs

After building, you'll find:

```
build/
├── app/
│   └── outputs/
│       ├── apk/
│       │   └── release/
│       │       └── app-release.apk
│       └── bundle/
│           └── release/
│               └── app-release.aab
```

## 📊 Code Statistics

### New Code Added

- **Flutter Files**: 7 new files
- **Kotlin Files**: 3 new files
- **Configuration Files**: 3 new files
- **Documentation**: 2 new files

### Lines of Code (Approximate)

- **Flutter/Dart**: ~3,500 lines
- **Kotlin**: ~800 lines
- **XML**: ~100 lines
- **Documentation**: ~500 lines

**Total**: ~4,900 lines of new code

## 🎯 Next Steps

1. ✅ Review the directory structure
2. ⚠️ Add TFLite model to `assets/models/`
3. ✅ Run `flutter pub get`
4. ✅ Build and test on physical device
5. ✅ Enable accessibility service manually
6. ✅ Test protection features

## 📞 Need Help?

Refer to `SAIFE_AI_IMPLEMENTATION.md` for detailed implementation guide.

---

**Last Updated**: December 2024
**Version**: 1.0.0



