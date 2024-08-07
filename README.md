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

To install all its package definitions, run:
```
./scripts/feeds update openplc
./scripts/feeds install -a -p openplc
```

## Binary Packages (opkg)

You can install prebuild packages via opkg for RPI and x86_64(KVM)
Add repo public key
```
wget -O /etc/opkg/keys/152ccf91cd6bfbdd http://feeds.lunatiki.de/openplc/releases/23.05.4/arm_cortex-a7_neon-vfpv4/152ccf91cd6bfbdd
```
Add repo
```
echo 'src/gz openplc http://feeds.lunatiki.de/openplc/releases/23.05.4/arm_cortex-a7_neon-vfpv4' >> /etc/opkg/customfeeds.conf
```
Install demo program depends on hardware layer https://github.com/thiagoralves/OpenPLC_v3/tree/master/webserver/core/hardware_layers
```
opkg update
opkg install openplc-program-blank-rpi_old
```

For X86_64 search and replace arm_cortex-a7_neon-vfpv4 with x86_64


## Development

Documentation for developing and extending OpenPLC can be found on [Github](https://github.com/thiagoralves/OpenPLC_v3) , the [Documantation](https://autonomylogic.com/docs/openplc-overview/) and the [Forum](https://openplc.discussion.community/)
