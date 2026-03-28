export THEOS = /Users/runner/theos
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:13.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BackeerLoader
BackeerLoader_FILES = Tweak.m
BackeerLoader_FRAMEWORKS = UIKit Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
