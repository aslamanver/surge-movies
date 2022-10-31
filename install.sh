if [[ $1 == "build" ]]; then
    flutter clean
    flutter build apk --release -t lib/main.dart
fi

adb install build/app/outputs/flutter-apk/app-release.apk
