include $(TOPDIR)/rules.mk

PKG_NAME:=openplc-glue-generator
PKG_VERSION:=3
PKG_RELEASE:=2
PKG_SOURCE_URL:=https://github.com/thiagoralves/OpenPLC_v3.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-05-01
PKG_SOURCE_VERSION:=b4702061dc14d1024856f71b4543298d77007b88
#PKG_SOURCE_VERSION:=master
PKG_MIRROR_HASH:=skip
PKG_LICENSE:=LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING.LESSER
PKG_SOURCE_SUBDIR:=openplc-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OpenPLC glue-generator version 3
  URL:=https://github.com/thiagoralves/OpenPLC_v3
  DEPENDS:=+libstdcpp +openplc
endef

define Package/$(PKG_NAME)/description
  glue-generator
endef

#$(PKG_UNPACK)
define Build/Prepare
	cp -a $(BUILD_DIR)/openplc-$(PKG_VERSION)/utils/glue_generator_src/* $(PKG_BUILD_DIR)/
	$(call Build/Prepare/Default)
endef

define Build/Compile
    $(TARGET_CXX) -std=c++11 $(PKG_BUILD_DIR)/glue_generator.cpp -o $(PKG_BUILD_DIR)/glue_generator
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/libexec/openplc/webserver/core
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/glue_generator $(1)/usr/libexec/openplc/webserver/core/
endef

$(eval $(call BuildPackage,openplc-glue-generator))
