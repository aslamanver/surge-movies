echo "const apiKey = 'YOUR_API_KEY';" | cat > lib/secrets/keys.dart
flutter clean
flutter build apk --release -t lib/main.dart