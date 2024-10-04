include $(TOPDIR)/rules.mk

PKG_NAME:=openplc-dnp
CMAKE_INSTALL:=1
PKG_VERSION:=3
PKG_RELEASE:=1
PKG_SOURCE_URL:=https://github.com/thiagoralves/OpenPLC_v3.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-05-01
PKG_SOURCE_VERSION:=b4702061dc14d1024856f71b4543298d77007b88
PKG_MIRROR_HASH:=a57f35651a4d4e0901b09994a3d81736dc79e14a03f72c1afddee37669dde6da
PKG_LICENSE:=LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING.LESSER
PKG_SOURCE_SUBDIR:=openplc-$(PKG_VERSION)-git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_PARALLEL:=0

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
	cp -a $(BUILD_DIR)/openplc-$(PKG_VERSION)-git/utils/dnp3_src/* $(PKG_BUILD_DIR)/
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
