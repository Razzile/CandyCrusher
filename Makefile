TARGET = iphone:9.2

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CrusherV3
CrusherV3_FILES = New.xm Settings.mm
CrusherV3_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk


SUBPROJECTS += crusherprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
