cd HostApp

sh generate_project.sh

# sh test_project.sh 'platform=macOS,name=Any Mac'
# sh test_project.sh 'platform=macOS,varint=Mac Catalyst,name=Any Mac'
sh test_project.sh 'platform=iOS Simulator,name=Any iOS Simulator Device'
# sh test_project.sh 'platform=tvOS Simulator,name=Any tvOS Simulator Device'
# sh test_project.sh 'platform=watchOS Simulator,name=Any watchOS Simulator Device'
# sh test_project.sh 'platform=visionOS Simulator,name=Any visionOS Simulator Device'
