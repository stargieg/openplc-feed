include $(TOPDIR)/rules.mk

PKG_NAME:=openplc-glue-generator
PKG_VERSION:=3
PKG_RELEASE:=3
PKG_MAINTAINER:=Patrick Grimm <patrick@lunatiki.de>
PKG_SOURCE_URL:=https://github.com/thiagoralves/OpenPLC_v3.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBMODULES:=skip
PKG_SOURCE_DATE:=2025-09-11
PKG_SOURCE_VERSION:=4d8d73f57cf2e4b679bec6cd0daf07939e527a38
PKG_MIRROR_HASH:=80b5f3f081b5d0aa9eeaa076b836989e493fbb8ea923d88323135e19e365594c
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
