include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=ethercat
PKG_VERSION:=1.5
PKG_RELEASE:=2
PKG_SOURCE_URL:=https://gitlab.com/etherlab.org/ethercat.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=stable-1.5
PKG_MIRROR_HASH:=f53f791c3f02ff82dbda87444d1a721e9acc2502c5c681cf0e2bd66e0fdff431
PKG_LICENSE:=LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING.LESSER
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
RSTRIP:=:
STRIP:=:

define KernelPackage/$(PKG_NAME)
  SUBMENU:=Network Devices
  TITLE:=EtherCAT Master from EtherLab
  URL:=https://gitlab.com/etherlab.org/ethercat
  AUTOLOAD:=$(call AutoLoad,50,ec_master) \
    $(call AutoLoad,50,ec_generic)
  FILES:=$(PKG_BUILD_DIR)/master/ec_master.ko \
    $(PKG_BUILD_DIR)/devices/ec_generic.ko
endef

include $(INCLUDE_DIR)/kernel-defaults.mk

define Package/$(PKG_NAME)/description
  ethercat
endef

define Build/Prepare
	$(Build/Prepare/Default)
	(cd $(PKG_BUILD_DIR) && ./bootstrap)
endef

CONFIGURE_ARGS +=--enable-8139too=no
CONFIGURE_ARGS +=--with-linux-dir="$(LINUX_DIR)"

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" \
		KERNEL_DIR="$(LINUX_DIR)" \
		ARCH="$(LINUX_KARCH)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		M="$(PKG_BUILD_DIR)" \
		V="$(V)" \
		CFLAGS_MODULE=$(NOXTABLES) \
		modules
endef

$(eval $(call KernelPackage,ethercat))
