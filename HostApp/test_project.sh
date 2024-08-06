rm -rf TestResults.xcresult

xcodebuild \
-configuration "Debug" \
-project HostApp.xcodeproj \
-scheme HostApp \
-destination "$1" \
-resultBundlePath TestResults.xcresult \
test
