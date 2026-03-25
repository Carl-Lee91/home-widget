# Flutter Home Widget 구현 가이드 (Method Channel 기반)

> Flutter 앱에서 iOS/Android 네이티브 홈 위젯을 Method Channel로 구현하는 가이드.
> 별도 pub.dev 패키지 없이 순수 네이티브 코드로 구현한다.

---

## 목차

1. [아키텍처 개요](#1-아키텍처-개요)
2. [데이터 모델](#2-데이터-모델)
3. [Flutter 구현](#3-flutter-구현)
4. [Android 구현](#4-android-구현)
5. [iOS 구현](#5-ios-구현)
6. [데이터 플로우](#6-데이터-플로우)
7. [Xcode 수동 설정](#7-xcode-수동-설정)
8. [리스크 및 대응](#8-리스크-및-대응)
9. [체크리스트](#9-체크리스트)

---

## 1. 아키텍처 개요

```
Flutter App ──MethodChannel──▶ Native (iOS / Android)
                                      │
                                ┌─────┴─────┐
                                │ SharedData │
                                └─────┬─────┘
                                      │
                                Native Widget
                           (WidgetKit / AppWidget)
```

**핵심 원칙:**
- 네이티브 저장소가 Single Source of Truth (Flutter SharedPreferences 이중 저장 금지)
- iOS: App Group UserDefaults
- Android: SharedPreferences
- Method Channel은 앱 포그라운드에서만 동작, 위젯은 네이티브 저장소를 직접 읽음

---

## 2. 데이터 모델

네이티브 공유 저장소에 저장되는 키:

| Key | Type | 설명 |
|---|---|---|
| `action_done` | bool | 유저 액션 수행 여부 |
| `widget_title` | String | 위젯 타이틀 텍스트 |
| `widget_message` | String | 위젯 메시지 텍스트 |
| `widget_image_name` | String | 네이티브 이미지 에셋명 |
| `last_access_timestamp` | int (ms) | 마지막 앱 접속 시각 (epoch ms) |

---

## 3. Flutter 구현

### 3.1 파일 구조

```
lib/
  core/
    di/
      injector.dart                     # GetIt + Injectable
    channels/
      home_widget_method_channel.dart   # MethodChannel 래퍼
  data/
    repository/
      home_widget_repository_impl.dart  # Repository 구현체
  domain/
    entity/home_widget/
      home_widget_data.dart             # Freezed 모델
    repository/
      home_widget_repository.dart       # Abstract Repository
  presentation/
    home_widget/
      state/
        home_widget_bloc.dart           # BLoC (freezed 기반)
        home_widget_event.dart          # Events (part file)
        home_widget_state.dart          # State (part file)
      screens/
        home_widget_demo_screen.dart    # 화면
      widgets/
        action_button_widget.dart       # 액션 버튼
        widget_status_card.dart         # 상태 카드
```

### 3.2 Method Channel 서비스

채널명: `com.example.home_widget/widget` (앱 패키지명에 맞게 변경)

3개 메서드:
- `updateWidget({actionDone, title, message, imageName})` → 위젯 상태 업데이트
- `updateLastAccess({timestamp})` → 마지막 접속 시각 기록
- `forceRefresh()` → 위젯 강제 새로고침

```dart
@lazySingleton
class HomeWidgetMethodChannel {
  static const String channelName = 'com.example.home_widget/widget';
  final MethodChannel _channel = const MethodChannel(channelName);

  Future<bool> updateWidget({
    required bool actionDone,
    required String title,
    required String message,
    required String imageName,
  }) async {
    try {
      await _channel.invokeMethod<void>('updateWidget', {
        'action_done': actionDone,
        'widget_title': title,
        'widget_message': message,
        'widget_image_name': imageName,
      });
      return true;
    } on PlatformException catch (e) {
      debugPrint('[HomeWidget] updateWidget error: $e');
      return false;
    }
  }

  Future<bool> updateLastAccess() async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      await _channel.invokeMethod<void>('updateLastAccess', {
        'timestamp': timestamp,
      });
      return true;
    } on PlatformException catch (e) {
      debugPrint('[HomeWidget] updateLastAccess error: $e');
      return false;
    }
  }

  Future<bool> forceRefresh() async {
    try {
      await _channel.invokeMethod<void>('forceRefresh');
      return true;
    } on PlatformException catch (e) {
      debugPrint('[HomeWidget] forceRefresh error: $e');
      return false;
    }
  }
}
```

### 3.3 앱 라이프사이클 감지 (main.dart)

```dart
class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // 앱 복귀 시 마지막 접속 시각 네이티브에 전달
      getIt<HomeWidgetBloc>().add(const HomeWidgetAppResumed());
    }
  }
}
```

### 3.4 BLoC Event/State (Freezed 기반)

```dart
// Event
@freezed
sealed class HomeWidgetEvent with _$HomeWidgetEvent {
  const factory HomeWidgetEvent.actionPerformed() = HomeWidgetActionPerformed;
  const factory HomeWidgetEvent.actionReset() = HomeWidgetActionReset;
  const factory HomeWidgetEvent.appResumed() = HomeWidgetAppResumed;
}

// State
@freezed
sealed class HomeWidgetState with _$HomeWidgetState {
  const factory HomeWidgetState({
    @Default(false) bool actionDone,
    @Default(false) bool isLoading,
  }) = _HomeWidgetState;
}
```

---

## 4. Android 구현

### 4.1 파일 구조

```
android/app/
  build.gradle.kts                          # WorkManager 의존성 추가
  src/main/
    kotlin/com/example/home_widget/
      MainActivity.kt                       # MethodChannel 핸들러
      HomeWidgetProvider.kt                 # AppWidgetProvider
      HomeWidgetWorker.kt                   # WorkManager 워커
    res/
      layout/home_widget_layout.xml         # 위젯 레이아웃
      drawable/widget_background.xml        # 위젯 배경
      drawable/ic_action_done.xml           # 완료 아이콘
      drawable/ic_come_back.xml             # 복귀 요청 아이콘
      xml/home_widget_info.xml              # 위젯 메타데이터
    AndroidManifest.xml                     # receiver 등록
```

### 4.2 Gradle 의존성

```kotlin
// android/app/build.gradle.kts
dependencies {
    implementation("androidx.work:work-runtime-ktx:2.9.0")
}
```

### 4.3 MainActivity - Method Channel 핸들러

```kotlin
class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "updateWidget" -> {
                        // SharedPreferences에 저장 → 위젯 갱신
                    }
                    "updateLastAccess" -> {
                        // 타임스탬프 저장 → WorkManager 등록 → 위젯 갱신
                    }
                    "forceRefresh" -> {
                        // 위젯 강제 갱신
                    }
                }
            }
    }
}
```

### 4.4 AppWidgetProvider

```kotlin
class HomeWidgetProvider : AppWidgetProvider() {
    companion object {
        const val PREFS_NAME = "home_widget_prefs"
        const val INACTIVITY_THRESHOLD_MS = 60_000L // 개발: 1분

        fun updateWidgets(context: Context, manager: AppWidgetManager, ids: IntArray) {
            // SharedPreferences에서 데이터 읽기
            // timestamp=0이면 비활성 판정 skip (리스크 대응)
            // 상태별 RemoteViews 업데이트
        }
    }
}
```

### 4.5 WorkManager Worker (비활성 감지)

```kotlin
class HomeWidgetWorker(context: Context, params: WorkerParameters) : Worker(context, params) {
    override fun doWork(): Result {
        // 1. SharedPreferences에서 last_access_timestamp 읽기
        // 2. timestamp=0이면 즉시 return (리스크 대응)
        // 3. 비활성 판단: now - lastAccess >= threshold
        // 4. 비활성이면 위젯 텍스트 변경 + 갱신
        // 5. 아직 비활성 아니면 남은 시간만큼 OneTimeWorkRequest 재등록
        return Result.success()
    }
}
```

**WorkManager 주의사항:**
- `PeriodicWorkRequest` 최소 간격 15분
- 개발용으로 `OneTimeWorkRequest` + `setInitialDelay` 체이닝 사용
- 프로덕션에서는 `PeriodicWorkRequest` 사용 권장

### 4.6 AndroidManifest 등록

```xml
<receiver
    android:name=".HomeWidgetProvider"
    android:exported="true">
    <intent-filter>
        <action android:name="android.appwidget.action.APPWIDGET_UPDATE" />
    </intent-filter>
    <meta-data
        android:name="android.appwidget.provider"
        android:resource="@xml/home_widget_info" />
</receiver>
```

### 4.7 위젯 메타데이터 (home_widget_info.xml)

```xml
<appwidget-provider
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:minWidth="110dp"
    android:minHeight="110dp"
    android:updatePeriodMillis="1800000"
    android:initialLayout="@layout/home_widget_layout"
    android:resizeMode="horizontal|vertical"
    android:widgetCategory="home_screen"
    android:targetCellWidth="2"
    android:targetCellHeight="2" />
```

---

## 5. iOS 구현

### 5.1 파일 구조

```
ios/
  Runner/
    AppDelegate.swift                           # MethodChannel 핸들러
    Runner.entitlements                         # App Groups
  HomeWidgetExtension/
    HomeWidgetExtension.swift                   # WidgetKit 엔트리 포인트
    HomeWidgetTimelineProvider.swift            # TimelineProvider
    HomeWidgetEntryView.swift                   # SwiftUI 뷰
    HomeWidgetExtension.entitlements            # App Groups
    Info.plist
```

### 5.2 App Groups 설정

- App Group ID: `group.com.example.homeWidget` (앱에 맞게 변경)
- Runner와 Extension **양쪽 모두** App Groups capability 필요
- UserDefaults 생성 시: `UserDefaults(suiteName: "group.com.example.homeWidget")`

### 5.3 AppDelegate - Method Channel 핸들러

```swift
let channel = FlutterMethodChannel(
    name: "com.example.home_widget/widget",
    binaryMessenger: controller.binaryMessenger
)

channel.setMethodCallHandler { (call, result) in
    switch call.method {
    case "updateWidget":
        // App Group UserDefaults에 저장
        // WidgetCenter.shared.reloadAllTimelines()
    case "updateLastAccess":
        // 타임스탬프 저장
        // WidgetCenter.shared.reloadAllTimelines()
    case "forceRefresh":
        // WidgetCenter.shared.reloadAllTimelines()
    default:
        result(FlutterMethodNotImplemented)
    }
}
```

### 5.4 TimelineProvider (비활성 감지 핵심)

**별도 백그라운드 태스크 불필요. WidgetKit Timeline만으로 해결:**

```swift
func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
    let now = Date()
    var entries: [HomeWidgetEntry] = [createEntry(date: now)]

    let lastAccessMs = defaults?.integer(forKey: "last_access_timestamp") ?? 0

    // 리스크 대응: timestamp=0이면 비활성 스케줄 안 함
    if !entry.isInactive && lastAccessMs > 0 {
        let inactivityDate = lastAccessDate + threshold
        if inactivityDate > now {
            // 비활성 시점에 자동 렌더링될 엔트리 추가
            entries.append(inactiveEntry(at: inactivityDate))
        }
    }

    let timeline = Timeline(entries: entries, policy: .after(refreshDate))
    completion(timeline)
}
```

**동작 원리:**
1. 앱 복귀 시 `updateLastAccess` → UserDefaults에 타임스탬프 저장 → `reloadAllTimelines()`
2. `getTimeline()`에서 두 개의 Entry 생성:
   - Entry 1: 현재 시각 → 현재 상태
   - Entry 2: `lastAccess + threshold` 시각 → "Come back!" 상태
3. WidgetKit이 Entry 2 시각 도달 시 **자동으로** UI 교체

### 5.5 SwiftUI View (상태별 UI)

```swift
struct HomeWidgetEntryView: View {
    var entry: HomeWidgetEntry

    var body: some View {
        ZStack {
            backgroundGradient  // 상태별 그라데이션
            VStack {
                Image(systemName: iconName)  // SF Symbols
                Text(entry.title)
                Text(entry.message)
            }
        }
    }
}
```

3가지 상태:
- **비활성**: 오렌지-레드 그라데이션 + `exclamationmark.circle.fill`
- **액션 완료**: 그린-블루 그라데이션 + `checkmark.circle.fill`
- **기본**: 퍼플-블루 그라데이션 + `hand.tap.fill`

### 5.6 Xcode 프로젝트 타겟 추가

Widget Extension은 **반드시 Xcode 프로젝트에 타겟 등록**이 필요하다.

**방법 A: Xcode GUI (권장)**
1. File > New > Target > Widget Extension
2. Product Name: `HomeWidgetExtension`
3. "Include Configuration App Intent" 체크 해제
4. 생성된 기본 파일을 준비한 파일로 교체

**방법 B: xcodeproj gem (자동화)**
```ruby
require 'xcodeproj'
project = Xcodeproj::Project.open('Runner.xcodeproj')

# 타겟 생성
ext_target = project.new_target(:app_extension, 'HomeWidgetExtension', :ios, '17.0')

# 빌드 설정
ext_target.build_configurations.each do |config|
  config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = 'com.example.homeWidget.HomeWidgetExtension'
  config.build_settings['CODE_SIGN_ENTITLEMENTS'] = 'HomeWidgetExtension/HomeWidgetExtension.entitlements'
  config.build_settings['INFOPLIST_FILE'] = 'HomeWidgetExtension/Info.plist'
end

# 소스 파일 추가
ext_group = project.main_group.new_group('HomeWidgetExtension', 'HomeWidgetExtension')
['HomeWidgetExtension.swift', 'HomeWidgetTimelineProvider.swift', 'HomeWidgetEntryView.swift'].each do |f|
  ref = ext_group.new_file(f)
  ext_target.source_build_phase.add_file_reference(ref)
end

# Runner에 의존성 + Embed 추가
runner_target.add_dependency(ext_target)
embed_phase = runner_target.new_copy_files_build_phase('Embed App Extensions')
embed_phase.dst_subfolder_spec = '13'
build_file = embed_phase.add_file_reference(ext_target.product_reference)
build_file.settings = { 'ATTRIBUTES' => ['RemoveHeadersOnCopy'] }

project.save
```

**주의: Embed App Extensions 빌드 페이즈는 Thin Binary 앞에 위치해야 사이클 에러 방지**

---

## 6. 데이터 플로우

### Flow 1: 유저 액션 수행

```
유저 버튼 탭
  → BLoC: HomeWidgetActionPerformed
  → Repository: updateWidgetForAction()
  → MethodChannel: invokeMethod('updateWidget', {action_done: true, ...})
  → iOS: UserDefaults 저장 → WidgetCenter.reloadAllTimelines() → SwiftUI 리렌더
  → Android: SharedPrefs 저장 → AppWidgetProvider.onUpdate() → RemoteViews 업데이트
```

### Flow 2: 비활성 감지

```
앱 실행/복귀
  → WidgetsBindingObserver: AppLifecycleState.resumed
  → BLoC: HomeWidgetAppResumed
  → MethodChannel: invokeMethod('updateLastAccess', {timestamp: now})
  → iOS: UserDefaults에 타임스탬프 저장
         → Timeline에 (timestamp + threshold) 엔트리 스케줄
         → threshold 경과 후 WidgetKit이 자동으로 "Come back!" 렌더
  → Android: SharedPrefs에 타임스탬프 저장
             → OneTimeWorkRequest(threshold 딜레이) 등록
             → threshold 경과 후 Worker가 비활성 확인 → 위젯 업데이트
```

---

## 7. Xcode 수동 설정

### App Groups 설정 (필수)

1. Xcode에서 `ios/Runner.xcworkspace` 열기
2. **Runner 타겟:**
   - Signing & Capabilities → + Capability → App Groups
   - `group.com.example.homeWidget` 추가
3. **HomeWidgetExtension 타겟:**
   - Signing & Capabilities → + Capability → App Groups
   - 동일한 `group.com.example.homeWidget` 추가
4. 양쪽 타겟에 Team(개발자 계정) 설정

### Signing 주의사항

- 실기기 배포 시 Provisioning Profile에 App Groups capability 포함 필요
- Extension의 Bundle ID는 메인 앱의 하위여야 함 (예: `com.example.app.WidgetExtension`)

---

## 8. 리스크 및 대응

| 리스크 | 대응 |
|---|---|
| `timestamp=0`일 때 즉시 비활성 판정 | `lastAccessMs > 0` 체크 → 0이면 비활성 판단 skip |
| Flutter/네이티브 이중 저장소 | 네이티브 저장소만 Single Source of Truth로 사용 |
| WidgetKit 갱신 예산 소진 | `reloadAllTimelines()` 호출 최소화 |
| WidgetKit 타임라인 타이밍 오차 | 프로덕션에서는 긴 임계값 사용 (수 시간~1일) |
| WorkManager 최소 간격 15분 | 개발: OneTimeWorkRequest 체이닝. 프로덕션: PeriodicWorkRequest |
| Android 제조사별 배터리 최적화 | 유저에게 배터리 최적화 해제 안내 고려 |
| 앱 종료 상태에서 위젯 동작 | 위젯은 네이티브 저장소 직접 읽음 (MethodChannel 불필요) |
| Xcode Widget Extension 타겟 | Xcode GUI 또는 xcodeproj gem으로 추가 |
| Embed App Extensions 빌드 사이클 | 빌드 페이즈 순서: Thin Binary 앞에 배치 |

---

## 9. 체크리스트

### 새 프로젝트에 적용 시

- [ ] Method Channel 채널명을 앱 패키지명에 맞게 변경
- [ ] App Group ID를 앱 Bundle ID에 맞게 변경
- [ ] Android `PREFS_NAME`을 앱에 맞게 변경
- [ ] `INACTIVITY_THRESHOLD_MS` 값을 프로덕션 요구사항에 맞게 조정
- [ ] 위젯 텍스트/이미지를 실제 컨텐츠로 교체
- [ ] Android: `build.gradle.kts`에 WorkManager 의존성 추가
- [ ] Android: `AndroidManifest.xml`에 receiver 등록
- [ ] iOS: Xcode에서 Widget Extension 타겟 추가
- [ ] iOS: Runner + Extension 양쪽에 App Groups 설정
- [ ] iOS: Embed App Extensions 빌드 페이즈 순서 확인
- [ ] 위젯 사이즈 결정 (iOS: supportedFamilies, Android: targetCellWidth/Height)
- [ ] `flutter analyze` 통과 확인
- [ ] iOS 시뮬레이터에서 위젯 추가 테스트
- [ ] Android 에뮬레이터에서 위젯 추가 테스트
- [ ] Flow 1 테스트: 앱에서 액션 → 위젯 변경 확인
- [ ] Flow 2 테스트: 앱 닫기 → threshold 경과 → 위젯 변경 확인

### 지원 가능 위젯 사이즈

**iOS (WidgetKit):**
| Family | 크기 | iOS 최소 |
|---|---|---|
| `.systemSmall` | 2x2 | 14.0 |
| `.systemMedium` | 4x2 | 14.0 |
| `.systemLarge` | 4x4 | 14.0 |
| `.systemExtraLarge` | 6x4 (iPad) | 15.0 |
| `.accessoryCircular` | 잠금화면 원형 | 16.0 |
| `.accessoryRectangular` | 잠금화면 직사각형 | 16.0 |
| `.accessoryInline` | 잠금화면 인라인 | 16.0 |

**Android (AppWidget):**
- `targetCellWidth` / `targetCellHeight`: 1~6 셀 자유 지정
- `resizeMode="horizontal|vertical"` → 유저가 드래그로 크기 조절 가능
- 여러 사이즈 프리셋 원하면 별도 AppWidgetProvider 등록
