include $(TOPDIR)/rules.mk

PKG_NAME:=ethercat-src
CMAKE_INSTALL:=1
PKG_VERSION:=3
PKG_RELEASE:=1
PKG_MAINTAINER:=Patrick Grimm <patrick@lunatiki.de>
PKG_SOURCE_URL:=https://github.com/r2k-in-the-vortex/ethercat_src.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBMODULES:=skip
PKG_SOURCE_DATE:=2024-05-08
PKG_SOURCE_VERSION:=main
PKG_MIRROR_HASH:=5df9850f52d48b96b2d1309d031d4973a63c261dec72893e2733710e8073ba23
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk
RSTRIP:=:
STRIP:=:

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OpenPLC ethercat version 3
  URL:=https://github.com/thiagoralves/OpenPLC_v3
  DEPENDS:=+libstdcpp +libxml2 +libxml2-dev +ethercat-tool
  EXTRA_DEPENDS:=libxml2-dev
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
