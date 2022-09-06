FLUTTER := $(shell which flutter)
FLUTTER_DIR := $(FLUTTER_BIN_DIR:/bin=)
DART := $(FLUTTER_BIN_DIR)/cache/dart-sdk/bin/dart

# # Obtain your API_KEY at https://localise.biz
# LOCALISE_KEY := ''
#
# SENTRY_AUTH_TOKEN := ''

MAX_LINE_LENGTH := 120

.PHONY: icon
icon:
	$(FLUTTER) pub run flutter_launcher_icons:main

.PHONY: splash
splash:
	$(FLUTTER) pub run flutter_native_splash:create

.PHONY: analyze
analyze:
	$(FLUTTER) analyze

.PHONY: format
format:
	$(FLUTTER) format -l $(MAX_LINE_LENGTH) .

.PHONY: test
test:
	$(FLUTTER) test

.PHONY: build-apk
build-apk:
	$(FLUTTER) build apk --verbose

.PHONY: build-bundle
build-bundle:
	$(FLUTTER) build appbundle --verbose

.PHONY: build-ios
build-ios-ad:
	$(FLUTTER) build ipa --verbose

.PHONY: internal-android
internal-android:
	cd android && fastlane internal

.PHONY: beta-android
beta-android:
	cd android && fastlane beta

.PHONY: build-ios
build-ios:
	cd ios && fastlane build_ios

.PHONY: deploy-ios
deploy-ios:
	cd ios && fastlane deploy_ios testflight:true

.PHONY: beta-ios
beta-ios: build-ios deploy-ios

.PHONY: b-r
b-r:
	$(FLUTTER) packages pub run build_runner build --delete-conflicting-outputs

.PHONY: clean
clean:
	$(FLUTTER) clean
	$(FLUTTER) pub get

.PHONY: i-clean
i-clean:
	$(FLUTTER) clean
	$(FLUTTER) pub get
	cd ios
	pod update
	cd ..

.PHONY: cocoa-pods-update
coco:
	cd ios
	sudo gem install cocoapods
	pod update

.PHONY: watch
watch:
	$(FLUTTER) packages pub run build_runner watch --delete-conflicting-outputs

.PHONY: l10n
l10n:
	$(FLUTTER) gen-l10n

.PHONY: l10n-sync
l10n-sync:
	./scripts/update-l10n.sh $(LOCALISE_KEY)
