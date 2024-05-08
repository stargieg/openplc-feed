include $(TOPDIR)/rules.mk

PKG_NAME:=ethercat-src
CMAKE_INSTALL:=1
PKG_VERSION:=3
PKG_RELEASE:=1
PKG_SOURCE_URL:=https://github.com/r2k-in-the-vortex/ethercat_src.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-05-08
PKG_SOURCE_VERSION:=main
PKG_MIRROR_HASH:=09b106f7d5abcba0756cccdbf938c0d4381fd86cdbf929fecdd67d0dc5f8e1b2
PKG_LICENSE:=LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING.LESSER

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk
RSTRIP:=:
STRIP:=:

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OpenPLC ethercat version 3
  URL:=https://github.com/thiagoralves/OpenPLC_v3
  DEPENDS:=+libstdcpp +libxml2 +ethercat-tool
endef

define Package/$(PKG_NAME)/description
  ethercat
endef

define Build/Prepare
	$(Build/Prepare/Default)
	cp -a $(PKG_BUILD_DIR)/conf/ethercat.cfg $(PKG_BUILD_DIR)/
	cp -a $(PKG_BUILD_DIR)/conf/master_config.xml $(PKG_BUILD_DIR)/
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/src/ethercat_src.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libethercat_src.so $(1)/usr/lib/
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/uci-defaults.sh $(1)/etc/uci-defaults/40_ethercat-src
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/src/ethercat_src.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libethercat_src.so $(1)/usr/lib/
endef

$(eval $(call BuildPackage,ethercat-src))
