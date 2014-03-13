LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# List obtained using
# adb shell busybox --list |sed 's/.$/ \\/' |sed 's/^/\t/'
BUSYBOX_TOOLS := \
	top \
	vi \
	less

LOCAL_MODULE := busybox

BUSYBOX_INSTALL_DIR := $(TARGET_OUT)/bin
BUSYBOX_BINARY := $(BUSYBOX_INSTALL_DIR)/busybox
BUSYBOX_LOCAL_BINARY := $(LOCAL_PATH)/busybox-android
# This dependency ensures busybox is installed after all toolbox symlinks
# are done, and overwrites them
$(BUSYBOX_BINARY): toolbox
	@cp $(BUSYBOX_LOCAL_BINARY) $(BUSYBOX_BINARY)
	@echo "Installing busybox"
	@for tool in $(BUSYBOX_TOOLS) ; do \
		rm -rf $(BUSYBOX_INSTALL_DIR)/$$tool ; \
		ln -s busybox $(BUSYBOX_INSTALL_DIR)/$$tool ; \
	done

ALL_DEFAULT_INSTALLED_MODULES += $(BUSYBOX_BINARY)
