include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=raspicomm-module
PKG_RELEASE:=2
PKG_SOURCE_URL:=https://github.com/helioslite/raspicomm-module.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=2137751de6fb8c3fe5a3f6dc961d515d92d10d11
PKG_MIRROR_HASH:=53c02364ea68250f5c6ac9e09788f2b507f9afba4c4ae8a22004f41e6d5510ae
PKG_LICENSE:=LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING.LESSER

include $(INCLUDE_DIR)/package.mk

define KernelPackage/$(PKG_NAME)
  SUBMENU:=Network Devices
  TITLE:=raspicomm kernel module with tty driver support for rs485
  URL:=https://github.com/helioslite/raspicomm-module
  AUTOLOAD:=$(call AutoLoad,50,raspicommrs485)
  FILES:=$(PKG_BUILD_DIR)/raspicommrs485.ko
  DEPENDS:=@TARGET_bcm27xx
endef

include $(INCLUDE_DIR)/kernel-defaults.mk

define Package/$(PKG_NAME)/description
  raspicomm kernel module with tty driver support for rs485 (raspicommrs485.ko)
  char dev /dev/ttyRPC0
endef

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" \
		KERNEL_DIR="$(LINUX_DIR)" \
		ARCH="$(LINUX_KARCH)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		M="$(PKG_BUILD_DIR)" \
		V="$(V)" \
		CFLAGS_MODULE=$(NOXTABLES) \
		modules
endef

$(eval $(call KernelPackage,raspicomm-module))
