echo "...[BUILD-AUTH-SDK-CODE-PROCESSING]"
echo " "

cd ../infra_sdk/auth
# rm -rf .dart_tool
# rm pubspec.lock

flutter pub get
flutter pub upgrade

dart run build_runner build --delete-conflicting-outputs

echo " "
echo "...[BUILD-AUTH-SDK-CODE-SUCCESS]"
echo " "



echo "...[BUILD-ACCOUNT-SDK-CODE-PROCESSING]"
echo " "

cd ../account


flutter pub get
flutter pub upgrade

dart run build_runner build --delete-conflicting-outputs

echo " "
echo "...[BUILD-ACCOUNT-SDK-CODE-SUCCESS]"
echo " "



echo "...[BUILD-ENGAGEMENT-SDK-CODE-PROCESSING]"
echo " "

cd ../engagement


flutter pub get
flutter pub upgrade

dart run build_runner build --delete-conflicting-outputs

echo " "
echo "...[BUILD-ENGAGEMENT-SDK-CODE-SUCCESS]"
echo " "
