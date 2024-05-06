include $(TOPDIR)/rules.mk

PKG_NAME:=openplc-program-blank
PKG_VERSION:=3
PKG_RELEASE:=2
PKG_SOURCE_URL:=https://github.com/thiagoralves/OpenPLC_v3.git
PKG_MIRROR_HASH:=a57f35651a4d4e0901b09994a3d81736dc79e14a03f72c1afddee37669dde6da
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-05-01
PKG_SOURCE_VERSION:=b4702061dc14d1024856f71b4543298d77007b88
PKG_SOURCE_SUBDIR:=openplc-$(PKG_VERSION)-git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=openplc-glue-generator/host openplc-matiec/host openplc-st-optimizer/host

include $(INCLUDE_DIR)/package.mk
RSTRIP:=:
STRIP:=:

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OpenPLC Program version 3
  URL:=https://github.com/thiagoralves/OpenPLC_v3
  DEPENDS:=+libstdcpp +openplc-libmodbus +openplc-dnp
endef
define Package/$(PKG_NAME)/description
  Customer PLC Program
endef

define Build/Prepare
	$(PKG_UNPACK)
	cp -a $(BUILD_DIR)/openplc-$(PKG_VERSION)-git/webserver/* $(PKG_BUILD_DIR)/
	cp "$(PKG_BUILD_DIR)/core/hardware_layers/blank.cpp" "$(PKG_BUILD_DIR)/core/hardware_layer.cpp"
	$(Build/Patch)
endef

define Build/Compile
	echo "blank_program.st" > $(PKG_BUILD_DIR)/active_program
	$(STAGING_DIR_HOST)/bin/st_optimizer \
		$(PKG_BUILD_DIR)/st_files/blank_program.st \
		$(PKG_BUILD_DIR)/st_files/blank_program.st
	cd $(PKG_BUILD_DIR) ; \
		$(STAGING_DIR_HOST)/bin/iec2c -f -l -p -r -R -a $(PKG_BUILD_DIR)/st_files/blank_program.st
	mv -f $(PKG_BUILD_DIR)/POUS.c $(PKG_BUILD_DIR)/POUS.h $(PKG_BUILD_DIR)/core/
	mv -f $(PKG_BUILD_DIR)/LOCATED_VARIABLES.h $(PKG_BUILD_DIR)/VARIABLES.csv $(PKG_BUILD_DIR)/core/
	mv -f $(PKG_BUILD_DIR)/Config0.c $(PKG_BUILD_DIR)/Config0.h $(PKG_BUILD_DIR)/core/
	mv -f $(PKG_BUILD_DIR)/Res0.c $(PKG_BUILD_DIR)/core/
	$(TARGET_CXX) -std=gnu++11 -I $(PKG_BUILD_DIR)/core/lib \
		-c $(PKG_BUILD_DIR)/core/Config0.c \
		-o $(PKG_BUILD_DIR)/core/Config0.o \
		-lasiodnp3 -lasiopal -lopendnp3 -lopenpal -w
	$(TARGET_CXX) -std=gnu++11 -I $(PKG_BUILD_DIR)/core/lib \
		-c $(PKG_BUILD_DIR)/core/Res0.c \
		-o $(PKG_BUILD_DIR)/core/Res0.o \
		-lasiodnp3 -lasiopal -lopendnp3 -lopenpal -w
	cd $(PKG_BUILD_DIR)/core ; \
		$(STAGING_DIR_HOST)/bin/glue_generator
	$(TARGET_CXX) -std=gnu++11 $(PKG_BUILD_DIR)/core/*.cpp \
		$(PKG_BUILD_DIR)/core/*.o -o $(PKG_BUILD_DIR)/core/openplc \
		-I $(PKG_BUILD_DIR)/core/lib -pthread -fpermissive \
		`pkg-config --cflags --libs libmodbus` \
		-lasiodnp3 -lasiopal -lopendnp3 -lopenpal -w
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/libexec/openplc/core/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/core/openplc $(1)/usr/libexec/openplc/core/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/active_program $(1)/usr/libexec/openplc/
endef

$(eval $(call BuildPackage,openplc-program-blank))