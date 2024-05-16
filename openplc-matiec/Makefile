include $(TOPDIR)/rules.mk

PKG_NAME:=openplc-matiec
PKG_VERSION:=3
PKG_RELEASE:=2
PKG_SOURCE_URL:=https://github.com/thiagoralves/OpenPLC_v3.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-05-01
PKG_SOURCE_VERSION:=b4702061dc14d1024856f71b4543298d77007b88
PKG_MIRROR_HASH:=a57f35651a4d4e0901b09994a3d81736dc79e14a03f72c1afddee37669dde6da
PKG_LICENSE:=LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING.LESSER
PKG_SOURCE_SUBDIR:=openplc-$(PKG_VERSION)-git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/$(PKG_NAME)-$(PKG_VERSION)
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
RSTRIP:=:
STRIP:=:

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OpenPLC matiec version 3
  URL:=https://github.com/thiagoralves/OpenPLC_v3
  DEPENDS:=+libstdcpp
endef

define Package/$(PKG_NAME)/description
  The following compiler has been based on the
  FINAL DRAFT - IEC 61131-3, 2nd Ed. (2001-12-10)
endef

define Host/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(PKG_UNPACK)
	mkdir -p $(HOST_BUILD_DIR)/
	cp -a $(BUILD_DIR)/openplc-$(PKG_VERSION)-git/utils/matiec_src/* $(HOST_BUILD_DIR)/
endef

define Host/Install
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/iec2c $(STAGING_DIR_HOST)/bin/
endef

define Build/Prepare
	$(PKG_UNPACK)
	cp -a $(BUILD_DIR)/openplc-$(PKG_VERSION)-git/utils/matiec_src/* $(PKG_BUILD_DIR)/
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/libexec/openplc
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iec2c $(1)/usr/libexec/openplc/
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,openplc-matiec))
