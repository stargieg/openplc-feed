include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=raspicomm-module
PKG_RELEASE:=2
PKG_MAINTAINER:=Patrick Grimm <patrick@lunatiki.de>
PKG_SOURCE_URL:=https://github.com/helioslite/raspicomm-module.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=2137751de6fb8c3fe5a3f6dc961d515d92d10d11
PKG_MIRROR_HASH:=7c15fe2caa6497ef7284fb886e76b8480b6e8f35c94543c57900ea9acb34d0a9
PKG_LICENSE:=GPL
PKG_LICENSE_FILES:=

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
