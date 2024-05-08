include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=ethercat
PKG_VERSION:=1.5
PKG_RELEASE:=1
PKG_SOURCE_URL:=https://gitlab.com/etherlab.org/ethercat.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=stable-1.5
PKG_MIRROR_HASH:=d2ab528892f1886bf410132837a17fd20842ad825b882bb8d6adc7785d3d7a75
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
  AUTOLOAD:=$(call AutoLoad,50,ethercat)
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
