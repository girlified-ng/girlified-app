# Girlified - System Architecture

## 🏗️ High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         USER INTERFACE                          │
│                        (Flutter Layer)                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐        │
│  │  Protection  │  │   Activity   │  │   Settings   │        │
│  │  Dashboard   │  │   Screen     │  │   Screen     │        │
│  └──────────────┘  └──────────────┘  └──────────────┘        │
│         │                  │                  │                │
│         └──────────────────┴──────────────────┘                │
│                            │                                    │
│                    ┌───────▼────────┐                          │
│                    │   Dashboard    │                          │
│                    │   Controller   │                          │
│                    └───────┬────────┘                          │
│                            │                                    │
└────────────────────────────┼────────────────────────────────────┘
                             │
┌────────────────────────────┼────────────────────────────────────┐
│                    SERVICE LAYER                                │
│                     (Flutter Layer)                             │
├────────────────────────────┼────────────────────────────────────┤
│                            │                                    │
│  ┌──────────────┐  ┌──────▼──────┐  ┌──────────────┐         │
│  │   TFLite     │  │ Protection  │  │   Native     │         │
│  │   Service    │  │  Service    │  │   Service    │         │
│  └──────┬───────┘  └──────┬──────┘  └──────┬───────┘         │
│         │                  │                 │                  │
│         │                  │                 │                  │
│    ┌────▼────┐      ┌─────▼─────┐    ┌─────▼─────┐           │
│    │  Model  │      │Background │    │  Method   │           │
│    │Inference│      │  Service  │    │  Channel  │           │
│    └─────────┘      └───────────┘    └─────┬─────┘           │
│                                              │                  │
└──────────────────────────────────────────────┼──────────────────┘
                                               │
┌──────────────────────────────────────────────┼──────────────────┐
│                    NATIVE LAYER                                 │
│                   (Android/Kotlin)                              │
├──────────────────────────────────────────────┼──────────────────┤
│                                               │                  │
│                        ┌──────────────────────▼────────┐        │
│                        │  NativeMethodChannel          │        │
│                        └──────────┬────────────────────┘        │
│                                   │                              │
│         ┌─────────────────────────┼─────────────────────┐       │
│         │                         │                     │       │
│  ┌──────▼──────────┐   ┌─────────▼────────┐   ┌───────▼─────┐ │
│  │ Accessibility   │   │     Overlay      │   │  Permission  │ │
│  │    Service      │   │     Service      │   │   Manager    │ │
│  └──────┬──────────┘   └─────────┬────────┘   └──────────────┘ │
│         │                         │                              │
│         │                         │                              │
└─────────┼─────────────────────────┼──────────────────────────────┘
          │                         │
          │                         │
┌─────────▼─────────────────────────▼──────────────────────────────┐
│                    TARGET APPLICATIONS                           │
│                                                                  │
│    ┌──────────┐      ┌──────────┐      ┌──────────┐           │
│    │  TikTok  │      │Instagram │      │ YouTube  │           │
│    └──────────┘      └──────────┘      └──────────┘           │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

## 🔄 Data Flow

### 1. Protection Activation Flow

```
User Taps Shield
      │
      ▼
Protection Dashboard
      │
      ▼
Protection Service
      │
      ├─► Start Background Service
      │
      ├─► Send to Native Service
      │
      ▼
Native Method Channel
      │
      ▼
Accessibility Service
      │
      └─► Start Monitoring
```

### 2. Content Detection Flow

```
User Scrolls in TikTok
      │
      ▼
Accessibility Service
      │
      ├─► Detect Content Change
      │
      ├─► Extract Screen Text/Image
      │
      ▼
Content Analysis
      │
      ├─► TFLite Model (if available)
      │   └─► Image Classification
      │
      └─► Keyword Detection (fallback)
          └─► Text Analysis
      │
      ▼
Is Harmful?
      │
      ├─► YES ──────────────┐
      │                     │
      └─► NO (Continue)     │
                            │
                            ▼
                    Show Blur Overlay
                            │
                            ├─► "Scroll Away"
                            │   └─► Navigate Back
                            │
                            └─► "Reveal Content"
                                └─► Dismiss Overlay
                            │
                            ▼
                    Log to History
                            │
                            ▼
                    Update Statistics
                            │
                            ▼
                    Send Notification
```

### 3. Statistics Flow

```
Content Blocked
      │
      ▼
Accessibility Service
      │
      ├─► Increment Counter
      │
      ├─► Save to SharedPreferences
      │
      ├─► Broadcast Event
      │
      ▼
Native Method Channel
      │
      ▼
Protection Service
      │
      ├─► Update Local Stats
      │
      ├─► Save to History
      │
      └─► Notify UI
      │
      ▼
Activity Screen
      │
      └─► Display Updated Stats
```

## 🧩 Component Interactions

### Flutter ↔ Native Communication

```
┌─────────────────────────────────────────────────────────────┐
│                    FLUTTER SIDE                             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  NativeService.dart                                         │
│    │                                                        │
│    ├─► isAccessibilityServiceEnabled()                     │
│    ├─► openAccessibilitySettings()                         │
│    ├─► canDrawOverlays()                                   │
│    ├─► requestOverlayPermission()                          │
│    ├─► setProtectionActive(bool)                           │
│    ├─► updateSensitivity(double)                           │
│    └─► getStatistics()                                     │
│                                                             │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       │ Method Channel
                       │ "com.girlified.saife/native"
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                    NATIVE SIDE                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  NativeMethodChannel.kt                                     │
│    │                                                        │
│    ├─► Handle: isAccessibilityServiceEnabled               │
│    ├─► Handle: openAccessibilitySettings                   │
│    ├─► Handle: canDrawOverlays                             │
│    ├─► Handle: requestOverlayPermission                    │
│    ├─► Handle: setProtectionActive                         │
│    ├─► Handle: updateSensitivity                           │
│    └─► Handle: getStatistics                               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Event Streaming

```
┌─────────────────────────────────────────────────────────────┐
│                    NATIVE SIDE                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Accessibility Service                                      │
│    │                                                        │
│    └─► Content Blocked Event                               │
│                                                             │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       │ Event Channel
                       │ "com.girlified.saife/events"
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                    FLUTTER SIDE                             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  NativeService.nativeEvents                                 │
│    │                                                        │
│    └─► Stream<Map<String, dynamic>>                        │
│         │                                                   │
│         └─► Listen in Protection Service                   │
│              │                                              │
│              └─► Update UI                                 │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 📦 Module Dependencies

### Flutter Dependencies

```
Protection Dashboard ──┐
Activity Screen ───────┼──► Protection Service ──► Native Service
Settings Screen ───────┘                              │
                                                      │
Onboarding ──────────────────────────────────────────┘

TFLite Service ──► Protection Service
                   │
                   └──► Background Service
```

### Native Dependencies

```
MainActivity ──► NativeMethodChannel ──┬──► Accessibility Service
                                       │
                                       ├──► Overlay Service
                                       │
                                       └──► Permission Manager
```

## 🔐 Permission Flow

```
App Launch
    │
    ▼
First Time? ──YES──► Onboarding Screen
    │                      │
    NO                     ▼
    │              Permission Setup
    │                      │
    │                      ├─► Accessibility Service
    │                      │   └─► Open Settings
    │                      │
    │                      ├─► Display Over Apps
    │                      │   └─► Request Permission
    │                      │
    │                      └─► Notifications
    │                          └─► Request Permission
    │                      │
    │                      ▼
    │              All Granted?
    │                      │
    │                      YES
    │                      │
    └──────────────────────┘
                           │
                           ▼
                    Dashboard Screen
```

## 💾 Data Storage

### Local Storage Structure

```
SharedPreferences
├── protection_active: bool
├── sensitivity_level: double
├── blocked_count: int
├── scan_count: int
├── block_history: List<String>
└── [other settings]

Future: SQLite Database
├── blocked_content
│   ├── id
│   ├── app
│   ├── category
│   ├── timestamp
│   ├── severity
│   └── description
├── statistics
│   ├── date
│   ├── blocked_count
│   └── scan_count
└── settings
    └── [user preferences]
```

## 🎯 Critical Paths

### Path 1: Enable Protection

```
User → Dashboard → Toggle → Service → Native → Accessibility
                                                      │
                                                      ▼
                                                  Monitoring
```

### Path 2: Detect & Block

```
Content → Accessibility → Analysis → Harmful? → Overlay → User Action
                                         │
                                         NO
                                         │
                                         ▼
                                     Continue
```

### Path 3: View History

```
User → Activity Screen → Load History → Display Stats
                              │
                              └──► Filter → Update View
```

## 🔄 State Management

### App State

```
┌─────────────────────────────────────────┐
│         Global State (GetX)             │
├─────────────────────────────────────────┤
│                                         │
│  currentScreenIndex: Observable<int>    │
│  protectionActive: Observable<bool>     │
│  sensitivityLevel: Observable<double>   │
│  blockedCount: Observable<int>          │
│  scanCount: Observable<int>             │
│                                         │
└─────────────────────────────────────────┘
```

### Service State

```
┌─────────────────────────────────────────┐
│      Accessibility Service State       │
├─────────────────────────────────────────┤
│                                         │
│  isProtectionActive: bool               │
│  targetApps: Set<String>                │
│  overlayService: OverlayService?        │
│                                         │
└─────────────────────────────────────────┘
```

## 🚀 Execution Flow

### App Startup

```
1. main()
2. Initialize Flutter
3. Load ServiceRegistry
4. Check authentication
5. Navigate to Dashboard or Login
6. Initialize Protection Service
7. Check accessibility permission
8. Load saved state
9. Ready
```

### Background Monitoring

```
Loop (every 5 seconds):
  1. Check if protection active
  2. Monitor target apps
  3. Analyze new content
  4. Update statistics
  5. Send heartbeat
  6. Repeat
```

## 📊 Performance Considerations

### Optimization Points

1. **TFLite Inference**
   - Run on separate isolate
   - Cache model in memory
   - Batch processing if possible

2. **Accessibility Service**
   - Throttle event processing
   - Only monitor target apps
   - Efficient text extraction

3. **UI Updates**
   - Use reactive state management
   - Lazy loading for history
   - Pagination for large datasets

4. **Storage**
   - Limit history size
   - Periodic cleanup
   - Efficient queries

## 🔒 Security Architecture

### Privacy Layers

```
Layer 1: No Network
  └─► All processing on-device

Layer 2: No Screenshots
  └─► Only text/metadata extracted

Layer 3: Local Storage
  └─► Data never leaves device

Layer 4: User Control
  └─► Can disable anytime

Layer 5: Transparency
  └─► Clear permission explanations
```

## 📱 Platform-Specific

### Android Only Features

- Accessibility Service
- System Alert Window
- Foreground Service
- Package-specific monitoring

### iOS Considerations

⚠️ Current implementation is Android-only. iOS would require:
- Screen Time API (limited)
- App Extensions
- Different architecture
- More restrictions

## 🎯 Extension Points

### Easy to Add

1. **More Apps**: Add package names to target list
2. **More Categories**: Extend TFLite model output
3. **More Languages**: Add translation files
4. **More Stats**: Extend statistics tracking

### Requires Work

1. **Cloud Sync**: Add backend API
2. **Multi-device**: Implement sync protocol
3. **Parental Controls**: Add user management
4. **iOS Support**: Rewrite native layer

---

**This architecture provides a solid, scalable foundation for the Girlified app.**



