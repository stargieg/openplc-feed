include $(TOPDIR)/rules.mk

PKG_NAME:=python3-pymodbus
PKG_VERSION:=2.5.3
PKG_RELEASE:=1
PKG_SOURCE_URL:=https://github.com/pymodbus-dev/pymodbus.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v2.5.3
PKG_MIRROR_HASH:=d4bb6964bd246f78cf0f16eaa3b60625883ae28d0fb9cd24c61cd1dfaad75b36
PKG_LICENSE:=LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING.LESSER

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=python3 pymodbus
  URL:=https://github.com/pymodbus-dev/pymodbus
  EXTRA_DEPENDS:=python3-six, python3-pyserial
endef

define Package/$(PKG_NAME)/description
  pymodbus
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/python3.11/site-packages/pymodbus
	cp -a $(PKG_BUILD_DIR)/pymodbus/* $(1)/usr/lib/python3.11/site-packages/pymodbus/
endef

$(eval $(call BuildPackage,python3-pymodbus))
