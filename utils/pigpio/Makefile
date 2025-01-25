# Based on Brandon Low's work at https://groups.google.com/forum/#!msg/bup-list/HIeue2eiIKc/gmPpUururMoJ

include $(TOPDIR)/rules.mk

PKG_NAME:=pigpio
CMAKE_INSTALL:=1
PKG_VERSION:=79
PKG_RELEASE:=1
PKG_MAINTAINER:=Patrick Grimm <patrick@lunatiki.de>
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/joan2937/pigpio/archive/refs/tags/v$(PKG_VERSION)
PKG_HASH:=c5337c0b7ae888caf0262a6f476af0e2ab67065f7650148a0b21900b8d1eaed7
PKG_LICENSE:=Unlicense
PKG_LICENSE_FILES:=UNLICENCE

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk
RSTRIP:=:
STRIP:=:

define Package/pigpio/Default
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Pi GPIO library and daemon
  DEPENDS:=@TARGET_bcm27xx +librt +libpthread
  URL:=http://github.com/joan2937/pigpio
endef

define Package/pigpio
  $(call Package/pigpio/Default)
endef

define Package/pigpio-dev
  $(call Package/pigpio/Default)
  TITLE:=Pi GPIO library and daemon dev
  DEPENDS:=+pigpio
 endef

define Package/pigpio/description
  pigpio is a C library for the Raspberry which allows control of the General Purpose Input Outputs (GPIO).

  This package contains the core C library, pigpiod daemon, and pigs CLI tool.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/*.h $(1)/usr/include/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libpigpio*so* $(1)/usr/lib/
endef

define Package/pigpio/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/usr/sbin $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libpigpio*so* $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/pigs $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/pig2vcd $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/pigpiod $(1)/usr/sbin/
endef

define Package/pigpio-dev/install
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/include/*.h $(1)/usr/include/
endef

$(eval $(call BuildPackage,pigpio))
$(eval $(call BuildPackage,pigpio-dev))
