include $(TOPDIR)/rules.mk

PKG_NAME:=openplc
PKG_VERSION:=3
PKG_RELEASE:=5
PKG_MAINTAINER:=Patrick Grimm <patrick@lunatiki.de>
PKG_SOURCE_URL:=https://github.com/thiagoralves/OpenPLC_v3.git
PKG_MIRROR_HASH:=be77798066ee9586aa96f770cd41b10a1d98f7637dc621d0fff48367bdfb4952
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2025-01-18
PKG_SOURCE_VERSION:=01770ddd8ce88045ec5a95fa17f3ccae4d9bf2c0
PKG_SOURCE_SUBDIR:=openplc-$(PKG_VERSION)-git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
RSTRIP:=:
STRIP:=:

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OpenPLC Runtime version 3
  URL:=https://github.com/thiagoralves/OpenPLC_v3
  EXTRA_DEPENDS:=python3-flask, python3-werkzeug, python3-flask-login, gcc, bash
  DEPENDS:=+openplc-dnp +openplc-glue-generator +openplc-libmodbus \
    +openplc-matiec +openplc-st-optimizer +TARGET_x86:ethercat-src +python3-pymodbus \
	+TARGET_bcm27xx:pigpio-dev +TARGET_bcm27xx:wiringpi-dev
endef

define Package/$(PKG_NAME)/description
  This package is a Webserver flask.
endef

define Build/Prepare
	$(PKG_UNPACK)
	cp -a $(BUILD_DIR)/openplc-$(PKG_VERSION)-git/webserver/* $(PKG_BUILD_DIR)/
	mv "$(PKG_BUILD_DIR)/core/dnp3.cpp" "$(PKG_BUILD_DIR)/core/dnp3.disabled"
	cp "$(PKG_BUILD_DIR)/core/dnp3_dummy.disabled" "$(PKG_BUILD_DIR)/core/dnp3_dummy.cpp"
	cp "$(PKG_BUILD_DIR)/core/hardware_layers/blank.cpp" "$(PKG_BUILD_DIR)/core/hardware_layer.cpp"
	echo "linux" > "$(PKG_BUILD_DIR)/scripts/openplc_platform"
	echo "blank_linux" > "$(PKG_BUILD_DIR)/scripts/openplc_driver"
	$(Build/Patch)
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init.sh $(1)/etc/init.d/openplc
	$(INSTALL_DIR) $(1)/usr/libexec/openplc
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/*.py $(1)/usr/libexec/openplc/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/*.cfg $(1)/usr/libexec/openplc/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/*.db $(1)/usr/libexec/openplc/
	cp -a $(PKG_BUILD_DIR)/core $(1)/usr/libexec/openplc/
	cp -a $(PKG_BUILD_DIR)/lib $(1)/usr/libexec/openplc/
	cp -a $(PKG_BUILD_DIR)/scripts $(1)/usr/libexec/openplc/
	cp -a $(PKG_BUILD_DIR)/static $(1)/usr/libexec/openplc/
	cp -a $(PKG_BUILD_DIR)/st_files $(1)/usr/libexec/openplc/
endef

$(eval $(call BuildPackage,openplc))
