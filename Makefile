.PHONY: test
test:
	fvm flutter test

.PHONY: pub get
pub:
	fvm flutter pub get

.PHONY: build_runner
runner:
	fvm flutter pub run build_runner watch --delete-conflicting-outputs

.PHONY: build and upload for development
release_dev:
	make release_ios_dev
	make release_android_dev

.PHONY: build and upload ios for development
release_ios_dev:
	make build_ios_dev
	cd ios && fastlane ios development

.PHONY: build ios for development
build_ios_dev:
	fvm flutter build ipa --release --flavor development --dart-define=flavor=development --dart-define=connect=dev --export-options-plist=ios/Runner/ExportOptions.plist

.PHONY: build and upload apk for development
release_android_dev:
	make build_android_dev
	cd android && fastlane android development --env development

.PHONY: build android for development
build_android_dev:
	fvm flutter build apk --split-per-abi --release --flavor development --dart-define=flavor=development --dart-define=connect=dev
