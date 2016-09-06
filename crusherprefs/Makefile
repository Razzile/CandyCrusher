ARCHS = armv7 arm64
TARGET = iphone:9.2
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CrusherPrefs
CrusherPrefs_FILES = CrusherPrefs.mm CrusherCredits.mm
CrusherPrefs_INSTALL_PATH = /Library/PreferenceBundles
CrusherPrefs_FRAMEWORKS = UIKit
CrusherPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CrusherPrefs.plist$(ECHO_END)
