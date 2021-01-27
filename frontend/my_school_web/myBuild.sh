echo "writing " $(date +"%Y-%m-%d %H:%M") " to ./lib/currentVersion.dart "
echo "const String currentVersion = " \""version of" $(date +"%Y-%m-%d %H:%M")\" ";" > ./lib/currentVersion.dart
echo "running flutter clean"
flutter clean
echo "running flutter build web"
flutter build web

# sleep 9999999999999