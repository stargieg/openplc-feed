include $(TOPDIR)/rules.mk

PKG_NAME:=openplc-dnp
CMAKE_INSTALL:=1
PKG_VERSION:=3
PKG_RELEASE:=2
PKG_MAINTAINER:=Patrick Grimm <patrick@lunatiki.de>
PKG_SOURCE_URL:=https://github.com/thiagoralves/OpenPLC_v3.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBMODULES:=skip
PKG_SOURCE_DATE:=2025-01-18
PKG_SOURCE_VERSION:=01770ddd8ce88045ec5a95fa17f3ccae4d9bf2c0
PKG_MIRROR_HASH:=98538907879cd1bb5b9f3e50c651d7c2bf4ad21fd8b2db147d7fff15b4e42565
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk
RSTRIP:=:
STRIP:=:

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OpenPLC opendnp version 3
  URL:=https://github.com/thiagoralves/OpenPLC_v3
  DEPENDS:=+libstdcpp
endef

define Package/$(PKG_NAME)/description
  opendnp3
endef

define Build/Prepare
	$(PKG_UNPACK)
	cp -a $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)-git/utils/dnp3_src/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
	cd $(PKG_BUILD_DIR) ; cmake . ; make ; ldconfig
endef


define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/* $(1)/usr/lib/
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,openplc-dnp))
