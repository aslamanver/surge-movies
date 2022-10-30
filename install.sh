flutter clean
flutter build apk --release -t lib/main.dart
adb install build/app/outputs/flutter-apk/app-release.apk
# flutter build apk --debug -t lib/main.dart
# adb install build/app/outputs/flutter-apk/app-debug.apk