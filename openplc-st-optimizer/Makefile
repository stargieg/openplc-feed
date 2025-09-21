include $(TOPDIR)/rules.mk

PKG_NAME:=openplc-st-optimizer
PKG_VERSION:=3
PKG_RELEASE:=3
PKG_MAINTAINER:=Patrick Grimm <patrick@lunatiki.de>
PKG_SOURCE_URL:=https://github.com/thiagoralves/OpenPLC_v3.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBMODULES:=skip
PKG_SOURCE_DATE:=2025-09-11
PKG_SOURCE_VERSION:=4d8d73f57cf2e4b679bec6cd0daf07939e527a38
PKG_MIRROR_HASH:=3b0dac5a01598b55194407c779c96370a714c850db5d962ab59f9a4e74f69e05
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
  TITLE:=OpenPLC st-optimizer version 3
  URL:=https://github.com/thiagoralves/OpenPLC_v3
  DEPENDS:=+libstdcpp
endef

define Package/$(PKG_NAME)/description
 This program is responsible for the optimization process after the initial
 compilation from PLCOpen Editor. All it does is to scan the ST file for
 first-level IF statements and concatenate identical statements together
endef

define Host/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(PKG_UNPACK)
	mkdir -p $(HOST_BUILD_DIR)/
	cp -a $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)-git/utils/st_optimizer_src/* $(HOST_BUILD_DIR)/
endef

define Host/Compile
	$(HOSTCXX) -std=c++11 $(HOST_BUILD_DIR)/st_optimizer.cpp -o $(HOST_BUILD_DIR)/st_optimizer
endef

define Host/Install
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/st_optimizer $(STAGING_DIR_HOST)/bin/
endef

define Build/Prepare
	$(PKG_UNPACK)
	cp -a $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)-git/utils/st_optimizer_src/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
    $(TARGET_CXX) $(PKG_BUILD_DIR)/st_optimizer.cpp -o $(PKG_BUILD_DIR)/st_optimizer
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/libexec/openplc
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/st_optimizer $(1)/usr/libexec/openplc/
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,openplc-st-optimizer))
