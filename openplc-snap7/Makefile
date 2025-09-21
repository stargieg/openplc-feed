include $(TOPDIR)/rules.mk

PKG_NAME:=openplc-snap7
PKG_VERSION:=3
PKG_RELEASE:=3
PKG_MAINTAINER:=Patrick Grimm <patrick@lunatiki.de>
PKG_SOURCE_URL:=https://github.com/thiagoralves/OpenPLC_v3.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBMODULES:=skip
PKG_SOURCE_DATE:=2025-09-11
PKG_SOURCE_VERSION:=4d8d73f57cf2e4b679bec6cd0daf07939e527a38
PKG_MIRROR_HASH:=02bd2ce06ecdd581f527f53ad6392f3d77cf8db84d9a82feb59df2d0338ed58c
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=COPYING
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
RSTRIP:=:
STRIP:=:

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OpenPLC snap7 version 3
  URL:=https://github.com/thiagoralves/OpenPLC_v3
  DEPENDS:=+libstdcpp +libpthread +librt
endef

define Package/$(PKG_NAME)/description
  S7 Protocol implementation
endef

define Build/Prepare
	$(PKG_UNPACK)
	cp -a $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)-git/utils/snap7_src/* $(PKG_BUILD_DIR)/
	sed -e 's/MyWord = NULL/MyWord/' -i $(PKG_BUILD_DIR)/wrapper/oplc_snap7.cpp
endef

define Build/Compile
	mkdir -p $(PKG_INSTALL_DIR)/usr/lib ; \
	$(MAKE) -C "$(PKG_BUILD_DIR)/build/linux" \
	LibInstall="$(PKG_INSTALL_DIR)/usr/lib" \
	CXX="$(TARGET_CXX)" \
	CC="$(TARGET_CC)" \
	AR="$(TARGET_AR)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	CXXFLAGS="$(TARGET_CXXFLAGS) -O2 $(FPIC) -pedantic" \
	LinkerName="$(TARGET_GXX)" \
	SharedObjectLinkerName="$(TARGET_CXX) -shared $(FPIC)" \
	LinkOptions=" -O2" \
	install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/wrapper/oplc_snap7.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsnap7.so $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/libexec/openplc/core
	$(CP) $(PKG_BUILD_DIR)/wrapper/oplc_snap7.{cpp,h} $(1)/usr/libexec/openplc/core/
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/wrapper/oplc_snap7.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsnap7.so $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/libexec/openplc/core
	$(CP) $(PKG_BUILD_DIR)/wrapper/oplc_snap7.{cpp,h} $(1)/usr/libexec/openplc/core/
endef

$(eval $(call BuildPackage,openplc-snap7))
