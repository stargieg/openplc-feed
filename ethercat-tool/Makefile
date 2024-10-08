include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=ethercat-tool
PKG_VERSION:=1.5
PKG_RELEASE:=1
PKG_SOURCE_URL:=https://gitlab.com/etherlab.org/ethercat.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=stable-1.5
PKG_MIRROR_HASH:=befad8b5a08ad219dd4ec1d8fe297853b054e2b09bd71192b119f070c49299ff
PKG_LICENSE:=LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING.LESSER
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
RSTRIP:=:
STRIP:=:

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=EtherCAT Master from EtherLab
  URL:=https://gitlab.com/etherlab.org/ethercat
  DEPENDS:=+libstdcpp +kmod-ethercat
endef

define Package/$(PKG_NAME)/description
  ethercat tool
endef

define Build/Prepare
	$(Build/Prepare/Default)
	(cd $(PKG_BUILD_DIR) && ./bootstrap)
endef

CONFIGURE_ARGS +=--enable-8139too=no
CONFIGURE_ARGS +=--with-linux-dir="$(LINUX_DIR)"

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/include/*.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/lib/.libs/libethercat.so* $(1)/usr/lib/
	$(CP) $(PKG_BUILD_DIR)/lib/.libs/libethercat.a $(1)/usr/lib/
	$(CP) $(PKG_BUILD_DIR)/lib/libethercat.la $(1)/usr/lib/
endef


define Package/conffiles
/etc/ethercat.conf
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/include/*.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/lib/.libs/libethercat.so* $(1)/usr/lib/
	$(CP) $(PKG_BUILD_DIR)/lib/.libs/libethercat.a $(1)/usr/lib/
	$(CP) $(PKG_BUILD_DIR)/lib/libethercat.la $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/script/ethercat.conf $(1)/etc/
	$(INSTALL_DIR) $(1)//usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tool/ethercat $(1)/usr/bin/
endef

$(eval $(call BuildPackage,ethercat-tool))
