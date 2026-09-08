# Variables
CURR_DIR := ${CURDIR}
PROJECT_NAME = AEPCore
AEPCORE_TARGET_NAME = AEPCore
AEPSERVICES_TARGET_NAME = AEPServices
AEPLIFECYCLE_TARGET_NAME = AEPLifecycle
AEPIDENTITY_TARGET_NAME = AEPIdentity
AEPSIGNAL_TARGET_NAME = AEPSignal
AEPRULESENGINE_TARGET_NAME = AEPRulesEngine
AEPINTEGRATION_TEST_TARGET_NAME = AEPIntegrationTests

# Modules built directly from Package.swift (SPM) for release archiving, no CocoaPods
# involved. Each module gets its own archive path since xcodebuild archive against an SPM
# scheme (unlike the legacy AEP-All aggregate scheme) only produces one module per archive.
SPM_ARCHIVE_MODULES = $(AEPSERVICES_TARGET_NAME) $(AEPCORE_TARGET_NAME) $(AEPLIFECYCLE_TARGET_NAME) $(AEPIDENTITY_TARGET_NAME) $(AEPSIGNAL_TARGET_NAME) $(AEPRULESENGINE_TARGET_NAME)
# AEPRulesEngine is an external SPM dependency (not a product of this package), so it gets
# no auto-generated scheme here -- it must be archived from its own resolved checkout,
# where it IS the root package.
SPM_OWN_MODULES = $(AEPSERVICES_TARGET_NAME) $(AEPCORE_TARGET_NAME) $(AEPLIFECYCLE_TARGET_NAME) $(AEPIDENTITY_TARGET_NAME) $(AEPSIGNAL_TARGET_NAME)
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'

# CI variables - using values with defaults
IOS_DEVICE_NAME ?= iPhone 16
# If OS version is not specified, uses the first device name match in the list of available simulators
IOS_VERSION ?= 18.5
ifeq ($(strip $(IOS_VERSION)),)
    IOS_DESTINATION = "platform=iOS Simulator,name=$(IOS_DEVICE_NAME)"
else
    IOS_DESTINATION = "platform=iOS Simulator,name=$(IOS_DEVICE_NAME),OS=$(IOS_VERSION)"
endif

TVOS_DEVICE_NAME ?= Apple TV
# If OS version is not specified, uses the first device name match in the list of available simulators
TVOS_VERSION ?= 18.5
ifeq ($(strip $(TVOS_VERSION)),)
	TVOS_DESTINATION = "platform=tvOS Simulator,name=$(TVOS_DEVICE_NAME)"
else
	TVOS_DESTINATION = "platform=tvOS Simulator,name=$(TVOS_DEVICE_NAME),OS=$(TVOS_VERSION)"
endif

# Targets - test

aep-core-unit-test:
	@echo "######################################################################"
	@echo "### Unit Testing AEPCore"
	@echo "######################################################################"
	xcodebuild test -workspace $(PROJECT_NAME).xcworkspace -scheme $(AEPCORE_TARGET_NAME) -destination $(IOS_DESTINATION)  -derivedDataPath build/out -resultBundlePath build/$(AEPCORE_TARGET_NAME)-ios.xcresult -enableCodeCoverage YES
aep-core-tvos-unit-test:
	@echo "######################################################################"
	@echo "### Unit Testing AEPCore on tvOS"
	@echo "######################################################################"
	xcodebuild test -workspace $(PROJECT_NAME).xcworkspace -scheme $(AEPCORE_TARGET_NAME) -destination $(TVOS_DESTINATION)  -derivedDataPath build/out -resultBundlePath build/$(AEPCORE_TARGET_NAME)-tvos.xcresult -enableCodeCoverage YES
aep-services-unit-test:
	@echo "######################################################################"
	@echo "### Unit Testing AEPServices"
	@echo "######################################################################"
	xcodebuild test -workspace $(PROJECT_NAME).xcworkspace -scheme $(AEPSERVICES_TARGET_NAME) -destination $(IOS_DESTINATION) -derivedDataPath build/out -resultBundlePath build/$(AEPSERVICES_TARGET_NAME)-ios.xcresult -enableCodeCoverage YES
aep-services-tvos-unit-test:
	@echo "######################################################################"
	@echo "### Unit Testing AEPServices on tvOS"
	@echo "######################################################################"
	xcodebuild test -workspace $(PROJECT_NAME).xcworkspace -scheme $(AEPSERVICES_TARGET_NAME) -destination $(TVOS_DESTINATION) -derivedDataPath build/out -resultBundlePath build/$(AEPSERVICES_TARGET_NAME)-tvos.xcresult -enableCodeCoverage YES
aep-lifecycle-unit-test:
	@echo "######################################################################"
	@echo "### Unit Testing AEPLifecycle"
	@echo "######################################################################"
	xcodebuild test -workspace $(PROJECT_NAME).xcworkspace -scheme $(AEPLIFECYCLE_TARGET_NAME) -destination $(IOS_DESTINATION) -derivedDataPath build/out -resultBundlePath  build/$(AEPLIFECYCLE_TARGET_NAME)-ios.xcresult -enableCodeCoverage YES
aep-lifecycle-tvos-unit-test:
	@echo "######################################################################"
	@echo "### Unit Testing AEPLifecycle on tvOS"
	@echo "######################################################################"
	xcodebuild test -workspace $(PROJECT_NAME).xcworkspace -scheme $(AEPLIFECYCLE_TARGET_NAME) -destination $(TVOS_DESTINATION) -derivedDataPath build/out -resultBundlePath  build/$(AEPLIFECYCLE_TARGET_NAME)-tvos.xcresult -enableCodeCoverage YES
aep-identity-unit-test:
	@echo "######################################################################"
	@echo "### Unit Testing AEPIdentity"
	@echo "######################################################################"
	xcodebuild test -workspace $(PROJECT_NAME).xcworkspace -scheme $(AEPIDENTITY_TARGET_NAME) -destination $(IOS_DESTINATION) -derivedDataPath build/out -resultBundlePath build/$(AEPIDENTITY_TARGET_NAME)-ios.xcresult -enableCodeCoverage YES
aep-identity-tvos-unit-test:
	@echo "######################################################################"
	@echo "### Unit Testing AEPIdentity on tvOS"
	@echo "######################################################################"
	xcodebuild test -workspace $(PROJECT_NAME).xcworkspace -scheme $(AEPIDENTITY_TARGET_NAME) -destination $(TVOS_DESTINATION) -derivedDataPath build/out -resultBundlePath build/$(AEPIDENTITY_TARGET_NAME)-tvos.xcresult -enableCodeCoverage YES
aep-signal-unit-test:
	@echo "######################################################################"
	@echo "### Unit Testing AEPSignal"
	@echo "######################################################################"
	xcodebuild test -workspace $(PROJECT_NAME).xcworkspace -scheme $(AEPSIGNAL_TARGET_NAME) -destination $(IOS_DESTINATION) -derivedDataPath build/out -resultBundlePath build/$(AEPSIGNAL_TARGET_NAME)-ios.xcresult -enableCodeCoverage YES
aep-signal-tvos-unit-test:
	@echo "######################################################################"
	@echo "### Unit Testing AEPSignal on tvOS"
	@echo "######################################################################"
	xcodebuild test -workspace $(PROJECT_NAME).xcworkspace -scheme $(AEPSIGNAL_TARGET_NAME) -destination $(TVOS_DESTINATION) -derivedDataPath build/out -resultBundlePath build/$(AEPSIGNAL_TARGET_NAME)-tvos.xcresult -enableCodeCoverage YES

unit-test-all: aep-core-unit-test aep-core-tvos-unit-test aep-services-unit-test aep-services-tvos-unit-test aep-lifecycle-unit-test aep-lifecycle-tvos-unit-test aep-identity-unit-test aep-identity-tvos-unit-test aep-signal-unit-test aep-signal-tvos-unit-test

integration-test:
	@echo "######################################################################"
	@echo "### Integration Testing iOS"
	@echo "######################################################################"
	xcodebuild test -workspace $(PROJECT_NAME).xcworkspace -scheme $(AEPINTEGRATION_TEST_TARGET_NAME) -destination $(IOS_DESTINATION) -derivedDataPath build/out -enableCodeCoverage YES

integration-tvos-test:
	@echo "######################################################################"
	@echo "### Integration Testing tvOS"
	@echo "######################################################################"
	xcodebuild test -workspace $(PROJECT_NAME).xcworkspace -scheme $(AEPINTEGRATION_TEST_TARGET_NAME) -destination $(TVOS_DESTINATION) -derivedDataPath build/out -enableCodeCoverage YES

pod-install:
	pod install --repo-update

ci-pod-install:
	bundle exec pod install --repo-update

# Targets - archive
#
# These build the release xcframeworks directly from Package.swift (SPM), with no
# CocoaPods involved at all -- unlike the test targets above, which still build via the
# legacy AEPCore.xcworkspace/CocoaPods-linked project for now.

archive: _archive

archive-ios: _archive-ios

ci-archive: _archive

ci-archive-ios: _archive-ios

_archive: clean build-ios build-tvos
	@set -eo pipefail; \
	for module in $(SPM_ARCHIVE_MODULES); do \
		echo "Creating xcframework for $$module (iOS + tvOS)..."; \
		xcodebuild -create-xcframework \
			-framework ./build/$$module-ios_simulator.xcarchive/Products/usr/local/lib/$$module.framework \
			-debug-symbols $(CURR_DIR)/build/$$module-ios_simulator.xcarchive/dSYMs/$$module.framework.dSYM \
			-framework ./build/$$module-tvos_simulator.xcarchive/Products/usr/local/lib/$$module.framework \
			-debug-symbols $(CURR_DIR)/build/$$module-tvos_simulator.xcarchive/dSYMs/$$module.framework.dSYM \
			-framework ./build/$$module-ios.xcarchive/Products/usr/local/lib/$$module.framework \
			-debug-symbols $(CURR_DIR)/build/$$module-ios.xcarchive/dSYMs/$$module.framework.dSYM \
			-framework ./build/$$module-tvos.xcarchive/Products/usr/local/lib/$$module.framework \
			-debug-symbols $(CURR_DIR)/build/$$module-tvos.xcarchive/dSYMs/$$module.framework.dSYM \
			-output ./build/$$module.xcframework; \
	done

_archive-ios: clean build-ios
	@set -eo pipefail; \
	for module in $(SPM_ARCHIVE_MODULES); do \
		echo "Creating xcframework for $$module (iOS only)..."; \
		xcodebuild -create-xcframework \
			-framework ./build/$$module-ios_simulator.xcarchive/Products/usr/local/lib/$$module.framework \
			-debug-symbols $(CURR_DIR)/build/$$module-ios_simulator.xcarchive/dSYMs/$$module.framework.dSYM \
			-framework ./build/$$module-ios.xcarchive/Products/usr/local/lib/$$module.framework \
			-debug-symbols $(CURR_DIR)/build/$$module-ios.xcarchive/dSYMs/$$module.framework.dSYM \
			-output ./build/$$module.xcframework; \
	done

# Both targets below temporarily move the legacy Xcode project/workspace out of the way
# so xcodebuild's auto-detection has no ambiguous container to pick between (with both
# present, plain `xcodebuild -scheme <Module>` silently resolved to the legacy project's
# scheme instead of Package.swift's). Restored via `trap ... EXIT` even if the build fails,
# since the test targets earlier in this Makefile still need them.

build-ios:
	@set -eo pipefail; \
	mv AEPCore.xcodeproj .AEPCore.xcodeproj.bak; \
	mv AEPCore.xcworkspace .AEPCore.xcworkspace.bak; \
	trap 'mv .AEPCore.xcodeproj.bak AEPCore.xcodeproj; mv .AEPCore.xcworkspace.bak AEPCore.xcworkspace' EXIT; \
	for module in $(SPM_OWN_MODULES); do \
		echo "Archiving $$module for iOS device..."; \
		xcodebuild archive -scheme $$module -archivePath "./build/$$module-ios.xcarchive" -destination "generic/platform=iOS" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES; \
		echo "Archiving $$module for iOS simulator..."; \
		xcodebuild archive -scheme $$module -archivePath "./build/$$module-ios_simulator.xcarchive" -destination "generic/platform=iOS Simulator" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES; \
	done; \
	RULESENGINE_CHECKOUT=$$(find ~/Library/Developer/Xcode/DerivedData -maxdepth 6 -type d -ipath "*SourcePackages/checkouts*rulesengine*" 2>/dev/null | head -1); \
	if [ -z "$$RULESENGINE_CHECKOUT" ]; then echo "Could not find resolved AEPRulesEngine checkout under .build/checkouts"; exit 1; fi; \
	echo "Patching $$RULESENGINE_CHECKOUT/Package.swift to declare a dynamic library (needed for xcodebuild archive to produce a .framework bundle; upstream doesn't set this)"; \
	sed -i '' 's#\.library(name: "AEPRulesEngine", targets: \["AEPRulesEngine"\])#.library(name: "AEPRulesEngine", type: .dynamic, targets: ["AEPRulesEngine"])#' "$$RULESENGINE_CHECKOUT/Package.swift"; \
	echo "Archiving $(AEPRULESENGINE_TARGET_NAME) for iOS device from $$RULESENGINE_CHECKOUT..."; \
	(cd "$$RULESENGINE_CHECKOUT" && xcodebuild archive -scheme $(AEPRULESENGINE_TARGET_NAME) -archivePath "$(CURR_DIR)/build/$(AEPRULESENGINE_TARGET_NAME)-ios.xcarchive" -destination "generic/platform=iOS" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES); \
	echo "Archiving $(AEPRULESENGINE_TARGET_NAME) for iOS simulator from $$RULESENGINE_CHECKOUT..."; \
	(cd "$$RULESENGINE_CHECKOUT" && xcodebuild archive -scheme $(AEPRULESENGINE_TARGET_NAME) -archivePath "$(CURR_DIR)/build/$(AEPRULESENGINE_TARGET_NAME)-ios_simulator.xcarchive" -destination "generic/platform=iOS Simulator" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES)

build-tvos:
	@set -eo pipefail; \
	mv AEPCore.xcodeproj .AEPCore.xcodeproj.bak; \
	mv AEPCore.xcworkspace .AEPCore.xcworkspace.bak; \
	trap 'mv .AEPCore.xcodeproj.bak AEPCore.xcodeproj; mv .AEPCore.xcworkspace.bak AEPCore.xcworkspace' EXIT; \
	for module in $(SPM_OWN_MODULES); do \
		echo "Archiving $$module for tvOS device..."; \
		xcodebuild archive -scheme $$module -archivePath "./build/$$module-tvos.xcarchive" -destination "generic/platform=tvOS" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES; \
		echo "Archiving $$module for tvOS simulator..."; \
		xcodebuild archive -scheme $$module -archivePath "./build/$$module-tvos_simulator.xcarchive" -destination "generic/platform=tvOS Simulator" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES; \
	done; \
	RULESENGINE_CHECKOUT=$$(find ~/Library/Developer/Xcode/DerivedData -maxdepth 6 -type d -ipath "*SourcePackages/checkouts*rulesengine*" 2>/dev/null | head -1); \
	if [ -z "$$RULESENGINE_CHECKOUT" ]; then echo "Could not find resolved AEPRulesEngine checkout under .build/checkouts"; exit 1; fi; \
	echo "Patching $$RULESENGINE_CHECKOUT/Package.swift to declare a dynamic library (needed for xcodebuild archive to produce a .framework bundle; upstream doesn't set this)"; \
	sed -i '' 's#\.library(name: "AEPRulesEngine", targets: \["AEPRulesEngine"\])#.library(name: "AEPRulesEngine", type: .dynamic, targets: ["AEPRulesEngine"])#' "$$RULESENGINE_CHECKOUT/Package.swift"; \
	echo "Archiving $(AEPRULESENGINE_TARGET_NAME) for tvOS device from $$RULESENGINE_CHECKOUT..."; \
	(cd "$$RULESENGINE_CHECKOUT" && xcodebuild archive -scheme $(AEPRULESENGINE_TARGET_NAME) -archivePath "$(CURR_DIR)/build/$(AEPRULESENGINE_TARGET_NAME)-tvos.xcarchive" -destination "generic/platform=tvOS" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES); \
	echo "Archiving $(AEPRULESENGINE_TARGET_NAME) for tvOS simulator from $$RULESENGINE_CHECKOUT..."; \
	(cd "$$RULESENGINE_CHECKOUT" && xcodebuild archive -scheme $(AEPRULESENGINE_TARGET_NAME) -archivePath "$(CURR_DIR)/build/$(AEPRULESENGINE_TARGET_NAME)-tvos_simulator.xcarchive" -destination "generic/platform=tvOS Simulator" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES)

zip:
	cd build && zip -r -X $(AEPCORE_TARGET_NAME).xcframework.zip $(AEPCORE_TARGET_NAME).xcframework/
	cd build && zip -r -X $(AEPSERVICES_TARGET_NAME).xcframework.zip $(AEPSERVICES_TARGET_NAME).xcframework/
	cd build && zip -r -X $(AEPLIFECYCLE_TARGET_NAME).xcframework.zip $(AEPLIFECYCLE_TARGET_NAME).xcframework/
	cd build && zip -r -X $(AEPIDENTITY_TARGET_NAME).xcframework.zip $(AEPIDENTITY_TARGET_NAME).xcframework/
	cd build && zip -r -X $(AEPSIGNAL_TARGET_NAME).xcframework.zip $(AEPSIGNAL_TARGET_NAME).xcframework/
	cd build && zip -r -X $(AEPRULESENGINE_TARGET_NAME).xcframework.zip $(AEPRULESENGINE_TARGET_NAME).xcframework/
	swift package compute-checksum build/$(AEPCORE_TARGET_NAME).xcframework.zip
	swift package compute-checksum build/$(AEPSERVICES_TARGET_NAME).xcframework.zip
	swift package compute-checksum build/$(AEPLIFECYCLE_TARGET_NAME).xcframework.zip
	swift package compute-checksum build/$(AEPIDENTITY_TARGET_NAME).xcframework.zip
	swift package compute-checksum build/$(AEPSIGNAL_TARGET_NAME).xcframework.zip
	swift package compute-checksum build/$(AEPRULESENGINE_TARGET_NAME).xcframework.zip
# Targets - CI steps

clean:
	rm -rf ./build

format: lint-autocorrect swift-format

swift-format:
	swiftformat . --swiftversion 5.1

lint-autocorrect:	
	./Pods/SwiftLint/swiftlint --fix

lint:
	./Pods/SwiftLint/swiftlint lint

checkFormat:
	swiftformat . --lint --swiftversion 5.1

loc:
	# use the following brew command to install cloc
	# brew install cloc
	cloc AEPSignal/Sources AEPIdentity/Sources AEPLifecycle/Sources AEPCore/Sources AEPServices/Sources	

latest-version:
	(which jq)
	(echo "AEPServices - " && pod spec cat AEPServices | jq '.version' | tr -d '"')
	(echo "AEPCore - " && pod spec cat AEPCore | jq '.version' | tr -d '"')
	(echo "AEPIdentity - " && pod spec cat AEPIdentity | jq '.version' | tr -d '"')
	(echo "AEPLifecycle - " && pod spec cat AEPLifecycle | jq '.version' | tr -d '"')
	(echo "AEPSignal - " && pod spec cat AEPSignal | jq '.version' | tr -d '"')

version-source-code:
	(echo "AEPCore - ${BLUE}$(shell cat ./AEPCore/Sources/configuration/ConfigurationConstants.swift | egrep '\s*EXTENSION_VERSION\s*=\s*\"(.*)\"' | ruby -e "puts gets.scan(/\"(.*)\"/)[0] " | tr -d '"')${NC}")
	(echo "AEPIdentity - ${BLUE}$(shell cat ./AEPIdentity/Sources/IdentityConstants.swift | egrep '\s*EXTENSION_VERSION\s*=\s*\"(.*)\"' | ruby -e "puts gets.scan(/\"(.*)\"/)[0] " | tr -d '"')${NC}")
	(echo "AEPLifecycle - ${BLUE}$(shell cat ./AEPLifecycle/Sources/LifecycleConstants.swift | egrep '\s*EXTENSION_VERSION\s*=\s*\"(.*)\"' | ruby -e "puts gets.scan(/\"(.*)\"/)[0] " | tr -d '"')${NC}")
	(echo "AEPSignal - ${BLUE}$(shell cat ./AEPSignal/Sources/SignalConstants.swift | egrep '\s*EXTENSION_VERSION\s*=\s*\"(.*)\"' | ruby -e "puts gets.scan(/\"(.*)\"/)[0] " | tr -d '"')${NC}")

test-SPM-integration:
	(sh ./Script/test-SPM.sh)

test-podspec-testutils:
	(sh ./Script/test-podspec-testutils.sh)

api-check:
	(sh ./Script/api-check.sh  --check --platform ios)
	(sh ./Script/api-check.sh  --check --platform tvos)

api-dump:
	(sh ./Script/api-check.sh  --dump --platform ios)
	(sh ./Script/api-check.sh  --dump --platform tvos)