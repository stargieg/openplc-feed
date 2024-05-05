include $(TOPDIR)/rules.mk

PKG_NAME:=openplc-libmodbus
PKG_VERSION:=3
PKG_RELEASE:=7
PKG_SOURCE_URL:=https://github.com/thiagoralves/OpenPLC_v3.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-05-01
PKG_SOURCE_VERSION:=b4702061dc14d1024856f71b4543298d77007b88
PKG_MIRROR_HASH:=skip
PKG_LICENSE:=LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING.LESSER
PKG_CPE_ID:=cpe:/a:libmodbus:libmodbus
PKG_SOURCE_SUBDIR:=openplc-$(PKG_VERSION)-git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
RSTRIP:=:
STRIP:=:

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OpenPLC modbus version 3
  URL:=https://github.com/thiagoralves/OpenPLC_v3
  DEPENDS:=+openplc
endef

define Package/$(PKG_NAME)/description
  lib modbus
endef

define Build/Prepare
	cp -a $(BUILD_DIR)/openplc-$(PKG_VERSION)-git/utils/libmodbus_src/* $(PKG_BUILD_DIR)/
endef

CONFIGURE_ARGS += --disable-tests
TARGET_CFLAGS += $(FPIC)

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/modbus $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libmodbus.{so*,la} $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libmodbus.pc $(1)/usr/lib/pkgconfig/
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/modbus $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libmodbus.{so*,la} $(1)/usr/lib/
	$(CP) $(TOOLCHAIN_DIR)/lib/libpthread.a $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libmodbus.pc $(1)/usr/lib/pkgconfig/
endef

$(eval $(call BuildPackage,openplc-libmodbus))
