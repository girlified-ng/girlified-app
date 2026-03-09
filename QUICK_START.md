# Girlified - Quick Start Guide

## 🚀 Get Started in 5 Minutes

### Prerequisites

- Flutter SDK (3.5.3 or higher)
- Android Studio or VS Code
- Physical Android device (API 24+)
- Basic knowledge of Flutter and Kotlin

### Step 1: Install Dependencies (1 min)

```bash
cd /path/to/saife-ai-app
flutter pub get
```

### Step 2: Review the Changes (2 min)

Open these key files to understand what was implemented:

**Flutter Screens:**
- `lib/presentation/dashboard/protection_dashboard_screen.dart` - Main screen
- `lib/presentation/dashboard/activity_screen.dart` - History
- `lib/presentation/dashboard/settings_screen.dart` - Settings

**Native Android:**
- `android/app/src/main/kotlin/com/girlified/girlified/SaifeAccessibilityService.kt`
- `android/app/src/main/kotlin/com/girlified/girlified/OverlayService.kt`

### Step 3: Add TFLite Model (CRITICAL!)

⚠️ **The app won't work properly without this!**

1. Create or obtain a trained TFLite model
2. Place it here: `assets/models/harmful_content_detector.tflite`
3. See `assets/models/README.md` for training instructions

**For testing without a model:**
- The app will use keyword-based fallback detection
- This is NOT recommended for production

### Step 4: Build & Run (2 min)

```bash
# Connect your Android device
flutter devices

# Run in debug mode
flutter run

# Or build release APK
flutter build apk --release
```

### Step 5: Enable Permissions

After installing, you must manually enable:

1. **Accessibility Service**:
   - Settings → Accessibility → Girlified → Enable

2. **Display Over Other Apps**:
   - Settings → Special app access → Display over other apps → Girlified → Allow

3. **Notifications**:
   - Granted automatically or via in-app prompt

## 📱 Testing the App

### Test Flow

1. **Open the app** → Should see onboarding (first time)
2. **Complete onboarding** → Grant permissions
3. **Enable protection** → Toggle the shield button
4. **Open TikTok/Instagram/YouTube** → Service should monitor
5. **Scroll through content** → Overlay appears if harmful content detected
6. **Check Activity tab** → See blocked content history
7. **Adjust Settings** → Change sensitivity, manage apps

### What to Test

✅ **UI/UX**:
- [ ] All 3 screens load properly
- [ ] Navigation works smoothly
- [ ] Animations are smooth
- [ ] Dark theme looks good

✅ **Functionality**:
- [ ] Protection toggle works
- [ ] Sensitivity slider updates
- [ ] Activity screen shows data
- [ ] Settings save properly

✅ **Native Integration**:
- [ ] Accessibility service can be enabled
- [ ] Overlay appears (test with keywords)
- [ ] Notifications work
- [ ] App doesn't crash

✅ **Performance**:
- [ ] No lag when scrolling
- [ ] Battery usage is reasonable
- [ ] Memory usage is acceptable

## 🐛 Common Issues & Solutions

### Issue 1: "TFLite model not found"

**Solution**: Add the model file to `assets/models/` or use fallback detection.

### Issue 2: "Accessibility service not working"

**Solutions**:
- Ensure service is enabled in Settings → Accessibility
- Check if app has accessibility permission
- Restart the app after enabling
- Check Android logs: `adb logcat | grep Saife`

### Issue 3: "Overlay not appearing"

**Solutions**:
- Enable "Display over other apps" permission
- Check if protection is active (toggle should be ON)
- Test with known harmful keywords
- Check overlay permission: Settings → Special app access

### Issue 4: "App crashes on launch"

**Solutions**:
- Run `flutter clean && flutter pub get`
- Check for Kotlin/Gradle errors
- Ensure all dependencies are installed
- Check Android logs for stack trace

### Issue 5: "Build fails"

**Solutions**:
- Update Flutter: `flutter upgrade`
- Update dependencies: `flutter pub upgrade`
- Clean build: `flutter clean`
- Check `pubspec.yaml` for errors
- Ensure Android SDK is up to date

## 📊 What Was Changed

### New Features ✨

1. **3 New Screens**:
   - Protection Dashboard with animated shield
   - Activity screen with statistics
   - Settings with permission management

2. **Native Android Integration**:
   - Accessibility Service for monitoring
   - Blur overlay for content blocking
   - Method channels for communication

3. **AI Integration**:
   - TFLite service for on-device inference
   - Image and text analysis
   - Fallback keyword detection

4. **Background Service**:
   - Continuous monitoring
   - Notification system
   - Statistics tracking

5. **Onboarding Flow**:
   - 4-page introduction
   - Permission setup wizard
   - Visual guidance

### Updated Files 🔄

- `lib/core/constants/colors.dart` - Girlified branding
- `lib/components/navigation/custom_bottom_navigation.dart` - 3 tabs
- `lib/presentation/dashboard/dashboard.dart` - New screen structure
- `android/app/src/main/AndroidManifest.xml` - Permissions & services
- `pubspec.yaml` - New dependencies

### Files You Can Remove 🗑️ (Optional)

These old screens are no longer used:
- `lib/presentation/dashboard/home_screen.dart`
- `lib/presentation/dashboard/cycle_screen.dart`
- `lib/presentation/dashboard/scan_screen.dart`
- `lib/presentation/dashboard/results_screen.dart`
- `lib/presentation/dashboard/profile_screen.dart`

## 📚 Documentation

Detailed guides available:

1. **SAIFE_AI_IMPLEMENTATION.md** - Complete implementation guide
2. **DIRECTORY_STRUCTURE.md** - Project structure overview
3. **assets/models/README.md** - TFLite model training guide

## 🎯 Next Steps

### Immediate (Required)
1. ✅ Review the code
2. ⚠️ Add TFLite model
3. ✅ Test on physical device
4. ✅ Enable accessibility service

### Short Term (Recommended)
1. Train a production-quality TFLite model
2. Add SQLite database for history
3. Implement more robust error handling
4. Add unit and integration tests
5. Optimize performance

### Long Term (Optional)
1. Add more social media apps
2. Implement cloud sync (optional)
3. Add parental controls
4. Create admin dashboard
5. Add content reporting
6. Implement ML model updates

## 💡 Tips for Success

1. **Test on Real Device**: Accessibility services don't work on emulators
2. **Start Simple**: Use keyword detection first, then add ML model
3. **Monitor Performance**: Watch battery and memory usage
4. **Iterate**: Start with basic detection, improve over time
5. **User Feedback**: Test with real users and iterate

## 🆘 Need Help?

### Resources
- **Implementation Guide**: `SAIFE_AI_IMPLEMENTATION.md`
- **Directory Structure**: `DIRECTORY_STRUCTURE.md`
- **Model Training**: `assets/models/README.md`

### Support
- Email: support@girlified.com.ng
- Website: https://saifeai.girlified.com.ng

### Community
- Flutter Docs: https://flutter.dev
- TFLite Docs: https://tensorflow.org/lite
- Android Accessibility: https://developer.android.com/guide/topics/ui/accessibility

## ✅ Checklist

Before deploying to production:

- [ ] TFLite model trained and tested
- [ ] All permissions working correctly
- [ ] Overlay appears and functions properly
- [ ] Statistics tracking works
- [ ] Notifications are sent
- [ ] Performance is acceptable
- [ ] Battery usage is reasonable
- [ ] No memory leaks
- [ ] Error handling is robust
- [ ] User testing completed
- [ ] Privacy policy updated
- [ ] App store listing prepared

## 🎉 You're Ready!

The Girlified foundation is complete. Now:

1. Add your TFLite model
2. Test thoroughly
3. Iterate and improve
4. Deploy and protect users!

**Remember**: This is a safety-critical app. Test extensively before releasing.

---

**Built with ❤️ for women's safety**

Good luck! 🚀



