include theos/makefiles/common.mk

TWEAK_NAME = CrusherV3
CrusherV3_FILES = Tweak.xm Settings.mm
CrusherV3_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk


SUBPROJECTS += crusherprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
