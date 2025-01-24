include $(TOPDIR)/rules.mk

PKG_NAME:=openplc-glue-generator
PKG_VERSION:=3
PKG_RELEASE:=3
PKG_MAINTAINER:=Patrick Grimm <patrick@lunatiki.de>
PKG_SOURCE_URL:=https://github.com/thiagoralves/OpenPLC_v3.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2025-01-18
PKG_SOURCE_VERSION:=01770ddd8ce88045ec5a95fa17f3ccae4d9bf2c0
PKG_MIRROR_HASH:=98eef7942c9898abec77c5d61c71cf5d421db7bf3a381f6d719e5002739d5794
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
RSTRIP:=:
STRIP:=:

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OpenPLC glue-generator version 3
  URL:=https://github.com/thiagoralves/OpenPLC_v3
  DEPENDS:=+libstdcpp
endef

define Package/$(PKG_NAME)/description
  glue-generator
endef

define Host/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(PKG_UNPACK)
	mkdir -p $(HOST_BUILD_DIR)/
	cp -a $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)-git/utils/glue_generator_src/* $(HOST_BUILD_DIR)/
endef

define Host/Compile
	$(HOSTCXX) -std=c++11 $(HOST_BUILD_DIR)/glue_generator.cpp -o $(HOST_BUILD_DIR)/glue_generator
endef

define Host/Install
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/glue_generator $(STAGING_DIR_HOST)/bin/
endef

define Build/Prepare
	$(PKG_UNPACK)
	cp -a $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)-git/utils/glue_generator_src/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
	$(TARGET_CXX) -std=c++11 $(PKG_BUILD_DIR)/glue_generator.cpp -o $(PKG_BUILD_DIR)/glue_generator
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/libexec/openplc/core
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/glue_generator $(1)/usr/libexec/openplc/core/
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,openplc-glue-generator))
