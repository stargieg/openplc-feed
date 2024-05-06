include $(TOPDIR)/rules.mk

PKG_NAME:=openplc
PKG_VERSION:=3
PKG_RELEASE:=2
PKG_SOURCE_URL:=https://github.com/thiagoralves/OpenPLC_v3.git
PKG_MIRROR_HASH:=a57f35651a4d4e0901b09994a3d81736dc79e14a03f72c1afddee37669dde6da
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-05-01
PKG_SOURCE_VERSION:=b4702061dc14d1024856f71b4543298d77007b88
PKG_SOURCE_SUBDIR:=openplc-$(PKG_VERSION)-git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
RSTRIP:=:
STRIP:=:

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OpenPLC Runtime version 3
  URL:=https://github.com/thiagoralves/OpenPLC_v3
  EXTRA_DEPENDS:=python3-pip, python3-flask, python3-werkzeug, python3-flask-login, python3-pyserial, python3-six, gcc, bash
  DEPENDS:=+openplc-dnp +openplc-glue-generator +openplc-libmodbus +openplc-matiec +openplc-st-optimizer
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
