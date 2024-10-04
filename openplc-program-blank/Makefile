include $(TOPDIR)/rules.mk

PKG_NAME:=openplc-program-blank
PKG_VERSION:=3
PKG_RELEASE:=2
PKG_SOURCE_URL:=https://github.com/thiagoralves/OpenPLC_v3.git
PKG_MIRROR_HASH:=836660e0e9bcc2c9f205df77be4232975d1e06dffbb048fbc20221f0bb330b45
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-05-01
PKG_SOURCE_VERSION:=b4702061dc14d1024856f71b4543298d77007b88
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)/$(BUILD_VARIANT)
PKG_BUILD_DEPENDS:=openplc-glue-generator/host openplc-matiec/host openplc-st-optimizer/host

include $(INCLUDE_DIR)/package.mk
RSTRIP:=:
STRIP:=:

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=OpenPLC Program version 3
  VARIANT:=linux
  URL:=https://github.com/thiagoralves/OpenPLC_v3
  DEPENDS:=+libstdcpp +openplc +openplc-libmodbus +openplc-dnp +TARGET_x86:ethercat-src
  EXTRA_DEPENDS:=sqlite3-cli
endef

define Package/$(PKG_NAME)/description
  Customer PLC Program
endef

define Package/$(PKG_NAME)-rpi
  $(call Package/$(PKG_NAME))
  TITLE:=OpenPLC Program version 3 for RPI
  VARIANT:=rpi
  DEPENDS:=@TARGET_bcm27xx +libstdcpp +openplc-libmodbus +openplc-dnp +TARGET_bcm27xx:pigpio-dev
 endef

define Package/$(PKG_NAME)-rpi_old
  $(call Package/$(PKG_NAME))
  TITLE:=OpenPLC Program version 3 for old RPI
  VARIANT:=rpi_old
  DEPENDS:=@TARGET_bcm27xx +libstdcpp +openplc-libmodbus +openplc-dnp +TARGET_bcm27xx:wiringpi-dev
 endef

define Build/Prepare
	$(PKG_UNPACK)
	cp -a $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)/$(PKG_NAME)-$(PKG_VERSION)-git/webserver/* $(PKG_BUILD_DIR)/

	$(Build/Patch)
endef

ifeq ($(BUILD_VARIANT),linux)
define Build/Compile
	cp "$(PKG_BUILD_DIR)/core/hardware_layers/blank.cpp" "$(PKG_BUILD_DIR)/core/hardware_layer.cpp"
	$(STAGING_DIR_HOST)/bin/st_optimizer \
		$(PKG_BUILD_DIR)/st_files/blank_program.st \
		$(PKG_BUILD_DIR)/st_files/blank_program.st
	cd $(PKG_BUILD_DIR) ; \
		$(STAGING_DIR_HOST)/bin/iec2c -f -l -p -r -R -a $(PKG_BUILD_DIR)/st_files/blank_program.st
	mv -f $(PKG_BUILD_DIR)/POUS.c $(PKG_BUILD_DIR)/POUS.h $(PKG_BUILD_DIR)/core/
	mv -f $(PKG_BUILD_DIR)/LOCATED_VARIABLES.h $(PKG_BUILD_DIR)/VARIABLES.csv $(PKG_BUILD_DIR)/core/
	mv -f $(PKG_BUILD_DIR)/Config0.c $(PKG_BUILD_DIR)/Config0.h $(PKG_BUILD_DIR)/core/
	$(if $(CONFIG_TARGET_x86), sed -i '7s/^/#include "ethercat_src.h" /' $(PKG_BUILD_DIR)/Res0.c)
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
endif

ifeq ($(BUILD_VARIANT),rpi)
define Build/Compile
	cp "$(PKG_BUILD_DIR)/core/hardware_layers/raspberrypi.cpp" "$(PKG_BUILD_DIR)/core/hardware_layer.cpp"
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
		-I $(PKG_BUILD_DIR)/core/lib -pthread -fpermissive -lpigpio \
		`pkg-config --cflags --libs libmodbus` \
		-lasiodnp3 -lasiopal -lopendnp3 -lopenpal -w
endef
endif

ifeq ($(BUILD_VARIANT),rpi_old)
define Build/Compile
	cp "$(PKG_BUILD_DIR)/core/hardware_layers/raspberrypi_old.cpp" "$(PKG_BUILD_DIR)/core/hardware_layer.cpp"
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
		-I $(PKG_BUILD_DIR)/core/lib -pthread -fpermissive -lwiringPi \
		`pkg-config --cflags --libs libmodbus` \
		-lasiodnp3 -lasiopal -lopendnp3 -lopenpal -w
endef
endif

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/uci-defaults-rpi.sh $(1)/etc/uci-defaults/40_openplc-program
	$(INSTALL_BIN) ./files/uci-defaults.sh $(1)/etc/uci-defaults/50_openplc-program
	$(INSTALL_DIR) $(1)/usr/libexec/openplc/core/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/core/openplc $(1)/usr/libexec/openplc/core/blank_program
endef

define Package/$(PKG_NAME)-rpi/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/uci-defaults-rpi.sh $(1)/etc/uci-defaults/40_openplc-program
	$(INSTALL_BIN) ./files/uci-defaults.sh $(1)/etc/uci-defaults/50_openplc-program
	$(INSTALL_DIR) $(1)/usr/libexec/openplc/core
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/core/openplc $(1)/usr/libexec/openplc/core/blank_program
endef

define Package/$(PKG_NAME)-rpi_old/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/uci-defaults-rpi_old.sh $(1)/etc/uci-defaults/40_openplc-program
	$(INSTALL_BIN) ./files/uci-defaults.sh $(1)/etc/uci-defaults/50_openplc-program
	$(INSTALL_DIR) $(1)/usr/libexec/openplc/core
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/core/openplc $(1)/usr/libexec/openplc/core/blank_program
endef

$(eval $(call BuildPackage,openplc-program-blank))
$(eval $(call BuildPackage,openplc-program-blank-rpi))
$(eval $(call BuildPackage,openplc-program-blank-rpi_old))
