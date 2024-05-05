include $(TOPDIR)/rules.mk

PKG_NAME:=openplc-matiec
PKG_VERSION:=3
PKG_RELEASE:=2
PKG_SOURCE_URL:=https://github.com/thiagoralves/OpenPLC_v3.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-05-01
PKG_SOURCE_VERSION:=b4702061dc14d1024856f71b4543298d77007b88
PKG_MIRROR_HASH:=skip
PKG_LICENSE:=LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING.LESSER
PKG_SOURCE_SUBDIR:=openplc-$(PKG_VERSION)-git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OpenPLC matiec version 3
  URL:=https://github.com/thiagoralves/OpenPLC_v3
  DEPENDS:=+libstdcpp +openplc
endef

define Package/$(PKG_NAME)/description
  The following compiler has been based on the
  FINAL DRAFT - IEC 61131-3, 2nd Ed. (2001-12-10)
endef

define Build/Prepare
	cp -a $(BUILD_DIR)/openplc-$(PKG_VERSION)-git/utils/matiec_src/* $(PKG_BUILD_DIR)/
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/libexec/openplc
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iec2c $(1)/usr/libexec/openplc/
endef

$(eval $(call BuildPackage,openplc-matiec))
