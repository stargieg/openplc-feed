include $(TOPDIR)/rules.mk

PKG_NAME:=openplc
PKG_VERSION:=3
PKG_RELEASE:=2
PKG_SOURCE_URL:=https://github.com/thiagoralves/OpenPLC_v3.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-05-01
PKG_SOURCE_VERSION:=b4702061dc14d1024856f71b4543298d77007b88
#PKG_SOURCE_VERSION:=master
PKG_MIRROR_HASH:=skip
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OpenPLC Runtime version 3
  URL:=https://github.com/thiagoralves/OpenPLC_v3
  EXTRA_DEPENDS:=python3-pip, python3-flask, python3-werkzeug, python3-flask-login, python3-pyserial, python3-six, gcc, bash
endef
define Package/$(PKG_NAME)/description
  This package is a Webserver flask.
endef

define Build/Prepare
	$(PKG_UNPACK)
	mv "$(PKG_BUILD_DIR)/webserver/core/dnp3.cpp" "$(PKG_BUILD_DIR)/webserver/core/dnp3.disabled"
	cp "$(PKG_BUILD_DIR)/webserver/core/dnp3_dummy.disabled" "$(PKG_BUILD_DIR)/webserver/core/dnp3_dummy.cpp"
	cp "$(PKG_BUILD_DIR)/webserver/core/hardware_layers/blank.cpp" "$(PKG_BUILD_DIR)/webserver/core/hardware_layer.cpp"
	echo "linux" > "$(PKG_BUILD_DIR)/webserver/scripts/openplc_platform"
	echo "blank_linux" > "$(PKG_BUILD_DIR)/webserver/scripts/openplc_driver"
endef
#	$(call Build/Prepare/Default)

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init.sh $(1)/etc/init.d/openplc
	$(INSTALL_DIR) $(1)/usr/libexec/openplc/webserver/core
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/webserver/core/hardware_layers/blank.cpp $(1)/usr/libexec/openplc/webserver/core/hardware_layer.cpp
	cp -a $(PKG_BUILD_DIR)/webserver $(1)/usr/libexec/openplc/
endef

$(eval $(call BuildPackage,openplc))
