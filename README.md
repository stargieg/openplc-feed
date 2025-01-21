# OpenWrt OpenPLC feed

## Description

This is the OpenWrt "openplc"-feed containing open-source Programmable Logic Controller.

## Usage

This repository is intended to be layered on-top of an OpenWrt buildroot.
If you do not have an OpenWrt buildroot installed, see the documentation at:
[OpenWrt Buildroot – Installation](https://openwrt.org/docs/guide-developer/build-system/install-buildsystem) on the OpenWrt support site.

This feed is not enabled by default. Your feeds.conf should contain a line like:
```
src-git openplc https://github.com/stargieg/openplc-feed.git
```
For openwrt-23.05 use
```
src-git openplc https://github.com/stargieg/openplc-feed.git;openwrt-23.05
```

To install all its package definitions, run:
```
./scripts/feeds update openplc
./scripts/feeds install -a -p openplc
```

Add or change .config
```
CONFIG_PACKAGE_python3-flask=y
CONFIG_PACKAGE_python3-werkzeug=y
CONFIG_PACKAGE_python3-flask-login=y
CONFIG_PACKAGE_python3-six=y
CONFIG_PACKAGE_python3-pyserial=y
CONFIG_PACKAGE_python3-pymodbus=y
CONFIG_PACKAGE_gcc=y
CONFIG_PACKAGE_bash=y
CONFIG_PACKAGE_sqlite3-cli=y
CONFIG_PACKAGE_ethercat-src=y
CONFIG_PACKAGE_ethercat-tool=y
CONFIG_PACKAGE_openplc=y
CONFIG_PACKAGE_openplc-dnp=y
CONFIG_PACKAGE_openplc-glue-generator=y
CONFIG_PACKAGE_openplc-libmodbus=y
CONFIG_PACKAGE_openplc-matiec=y
CONFIG_PACKAGE_openplc-program-pid=y
CONFIG_PACKAGE_openplc-st-optimizer=y
```

### Usage of OpenWRT SDK

[Using the SDK](https://openwrt.org/docs/guide-developer/toolchain/using_the_sdk)

This example is for the most common use mips_24kc arch

```
wget https://downloads.openwrt.org/releases/23.05.5/targets/ath79/generic/openwrt-sdk-23.05.5-ath79-generic_gcc-12.3.0_musl.Linux-x86_64.tar.xz
tar -x -f openwrt-sdk-23.05.5-ath79-generic_gcc-12.3.0_musl.Linux-x86_64.tar.xz
cd openwrt-sdk-23.05.5-ath79-generic_gcc-12.3.0_musl.Linux-x86_64
grep " base" feeds.conf.default > feeds.conf
echo "src-git openplc https://github.com/stargieg/openplc-feed.git" >> feeds.conf
./scripts/feeds update
./scripts/feeds install -a
cat << EOF > .config
# CONFIG_ALL_NONSHARED is not set
# CONFIG_ALL_KMODS is not set
# CONFIG_ALL is not set
CONFIG_NO_STRIP=y
# CONFIG_AUTOREBUILD is not set
# CONFIG_AUTOREMOVE is not set
# CONFIG_IMAGEOPT is not set
CONFIG_PACKAGE_openplc-program-blank=m
CONFIG_PACKAGE_openplc-program-blank-rpi=m
CONFIG_PACKAGE_openplc-program-blank-rpi_old=m
CONFIG_PACKAGE_openplc-program-pid=m
CONFIG_PACKAGE_openplc-program-pid-rpi=m
CONFIG_PACKAGE_openplc-program-pid-rpi_old=m
CONFIG_PACKAGE_kmod-raspicomm-module=m
EOF
make defconfig
make package/feeds/openplc/openplc-program-blank/compile
make package/feeds/openplc/openplc-program-pid/compile
make package/feeds/openplc/raspicomm-module/compile
```
After the compilation is finished, the generated .ipk files are placed in the bin/packages directories inside the directory you extracted the SDK into.

### Usage of OpenWRT IB

[Using the imagebuilder (IB)](https://openwrt.org/docs/guide-user/additional-software/imagebuilder)

This example is for the most common use mips_24kc arch

```
wget https://downloads.openwrt.org/releases/23.05.5/targets/ath79/generic/openwrt-imagebuilder-23.05.5-ath79-generic.Linux-x86_64.tar.xz
tar -x -f openwrt-imagebuilder-23.05.5-ath79-generic.Linux-x86_64.tar.xz
cd openwrt-imagebuilder-23.05.5-ath79-generic.Linux-x86_64
cat << EOF >> repositories.conf
src/gz openplc http://feeds.lunatiki.de/openplc/releases/23.05.5/mips_24kc
EOF
wget -O keys/152ccf91cd6bfbdd http://feeds.lunatiki.de/openplc/releases/23.05.5/mips_24kc/152ccf91cd6bfbdd
make image PROFILE="glinet_gl-mifi" PACKAGES="openplc-program-pid"
```
After the build is finished, the generated firmware files are placed in the bin/targets directories inside the directory you extracted the IB into.

## Binary Packages (opkg)

You can install prebuild packages via opkg.
Add feed public key and feed url
### releases/23.05.5 ath79 generic
```
wget -O /etc/opkg/keys/152ccf91cd6bfbdd http://feeds.lunatiki.de/openplc/releases/23.05.5/mips_24kc/152ccf91cd6bfbdd
echo 'src/gz openplc http://feeds.lunatiki.de/openplc/releases/23.05.5/mips_24kc' >> /etc/opkg/customfeeds.conf
```
### releases/23.05.5 bcm27xx bcm2709
```
wget -O /etc/opkg/keys/152ccf91cd6bfbdd http://feeds.lunatiki.de/openplc/releases/23.05.5/arm_cortex-a7_neon-vfpv4/152ccf91cd6bfbdd
echo 'src/gz openplc http://feeds.lunatiki.de/openplc/releases/23.05.5/arm_cortex-a7_neon-vfpv4' >> /etc/opkg/customfeeds.conf
```
### releases/23.05.5 ipq806x generic
```
wget -O /etc/opkg/keys/152ccf91cd6bfbdd http://feeds.lunatiki.de/openplc/releases/23.05.5/arm_cortex-a15_neon-vfpv4/152ccf91cd6bfbdd
echo 'src/gz openplc http://feeds.lunatiki.de/openplc/releases/23.05.5/arm_cortex-a15_neon-vfpv4' >> /etc/opkg/customfeeds.conf
```
### releases/23.05.5 x86 64
```
wget -O /etc/opkg/keys/152ccf91cd6bfbdd http://feeds.lunatiki.de/openplc/releases/23.05.5/x86_64/152ccf91cd6bfbdd
echo 'src/gz openplc http://feeds.lunatiki.de/openplc/releases/23.05.5/x86_64' >> /etc/opkg/customfeeds.conf
```
### releases/23.05.5 x86 generic
```
wget -O /etc/opkg/keys/152ccf91cd6bfbdd http://feeds.lunatiki.de/openplc/releases/23.05.5/i386_pentium4/152ccf91cd6bfbdd
echo 'src/gz openplc http://feeds.lunatiki.de/openplc/releases/23.05.5/i386_pentium4' >> /etc/opkg/customfeeds.conf
```


Install demo program depends on hardware layer https://github.com/thiagoralves/OpenPLC_v3/tree/master/webserver/core/hardware_layers
```
opkg update
opkg install openplc-program-blank
# or
opkg install openplc-program-pid
# or
opkg install openplc-program-pid-rpi
# or
opkg install openplc-program-pid-rpi_old
```

## Development

Documentation for developing and extending OpenPLC can be found on [Github](https://github.com/thiagoralves/OpenPLC_v3) , the [Documantation](https://autonomylogic.com/docs/openplc-overview/) and the [Forum](https://openplc.discussion.community/)
