include $(TOPDIR)/rules.mk

PKG_NAME:=wiringpi
PKG_VERSION:=3.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/WiringPi/WiringPi/archive/refs/tags/$(PKG_VERSION)
PKG_HASH:=a81219e9ea0ce08295d2fc0457c69c4df0c6d2e846cb5817ba3247f673480d55
PKG_BUILD_DIR:=$(BUILD_DIR)/WiringPi-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
RSTRIP:=:
STRIP:=:

define Package/$(PKG_NAME)/Default
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=WiringPI (For Rapsberry pi)
  DEPENDS:=@TARGET_bcm27xx +libpthread
  URL:=https://github.com/WiringPi/WiringPi
endef

define Package/$(PKG_NAME)
  $(call Package/$(PKG_NAME)/Default)
endef

define Package/$(PKG_NAME)-dev
  $(call Package/$(PKG_NAME)/Default)
  TITLE:=Pi GPIO library and daemon dev
  DEPENDS:=+wiringpi
 endef

define Package/$(PKG_NAME)/description
  C GPIO libraries for the RPI
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/wiringPi \
	LINUX="$(LINUX_DIR)" \
	CC="$(TARGET_CC)" \
	CFLAGS="$(TARGET_CFLAGS) -I./" \
	STAGING_DIR="$(STAGING_DIR)" \
	LDFLAGS="$(TARGET_LDFLAGS)"
	$(MAKE) -C $(PKG_BUILD_DIR)/devLib \
	LINUX="$(LINUX_DIR)" \
	CC="$(TARGET_CC)" \
	CFLAGS="$(TARGET_CFLAGS) -I$(PKG_BUILD_DIR)/wiringPi" \
	STAGING_DIR="$(STAGING_DIR)" \
	LDFLAGS="$(TARGET_LDFLAGS) -L$(PKG_BUILD_DIR)/wiringPi -L$(PKG_BUILD_DIR)/devLib -L$(STAGING_DIR)/lib -L$(STAGING_DIR)/usr/lib"
	cp $(PKG_BUILD_DIR)/devLib/libwiringPiDev.so.* $(PKG_BUILD_DIR)/libwiringPiDev.so
	cp $(PKG_BUILD_DIR)/wiringPi/libwiringPi.so.* $(PKG_BUILD_DIR)/libwiringPi.so
	$(MAKE) -C $(PKG_BUILD_DIR)/gpio \
	LINUX="$(LINUX_DIR)" \
	CC="$(TARGET_CC)" \
	CFLAGS="$(TARGET_CFLAGS) -I$(PKG_BUILD_DIR)/wiringPi -I$(PKG_BUILD_DIR)/devLib" \
	STAGING_DIR="$(STAGING_DIR)" \
	LDFLAGS="$(TARGET_LDFLAGS) -L$(PKG_BUILD_DIR) -lwiringPiDev"
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/ $(1)/usr/lib
	cp $(PKG_BUILD_DIR)/devLib/libwiringPiDev.so* $(1)/usr/lib/libwiringPiDev.so
	cp $(PKG_BUILD_DIR)/devLib/*.h $(1)/usr/include/
	cp $(PKG_BUILD_DIR)/wiringPi/libwiringPi.so* $(1)/usr/lib/libwiringPi.so
	cp $(PKG_BUILD_DIR)/wiringPi/*.h $(1)/usr/include/
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib $(1)/usr/bin
	cp $(PKG_BUILD_DIR)/gpio/gpio $(1)/usr/bin/
	cp $(PKG_BUILD_DIR)/devLib/libwiringPiDev.so.* $(1)/usr/lib/libwiringPiDev.so
	cp $(PKG_BUILD_DIR)/wiringPi/libwiringPi.so.* $(1)/usr/lib/libwiringPi.so
endef

define Package/$(PKG_NAME)-dev/install
	$(INSTALL_DIR) $(1)/usr/include
	cp $(PKG_BUILD_DIR)/devLib/*.h $(1)/usr/include/
	cp $(PKG_BUILD_DIR)/wiringPi/*.h $(1)/usr/include/
endef

$(eval $(call BuildPackage,wiringpi))
$(eval $(call BuildPackage,wiringpi-dev))
