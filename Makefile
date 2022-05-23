include $(TOPDIR)/rules.mk
 
PKG_NAME:=mstflint
PKG_VERSION:=4.20.0
PKG_RELEASE:=1
 
PKG_SOURCE_VERSION:=v$(PKG_VERSION)-$(PKG_RELEASE)
PKG_SOURCE_URL:=https://github.com/Mellanox/mstflint/releases/download/$(PKG_SOURCE_VERSION)
PKG_SOURCE:=mstflint-$(PKG_VERSION)-$(PKG_RELEASE).tar.gz
PKG_HASH:=9223018cd2d5d9a2b6075d4d74377e87c81b92acf94fccb8678a7f9dcafe6a78

PKG_BUILD_DEPENDS:=libopenssl libstdcpp zlib libsqlite3

PKG_INSTALL:=1
CONFIGURE_PATH:=.
CONFIGURE_CMD:=./configure

include $(INCLUDE_DIR)/package.mk
 
define Package/mstflint
  SECTION:=base
  CATEGORY:=Network
  TITLE:=MSTFLINT Package - Firmware Burning and Diagnostics Tools
  URL:=www.mellanox.com
  DEPENDS:=+libopenssl +libsqlite3 +libstdcpp +zlib
endef
 
define Package/bridge/description
    This package contains a burning tool and diagnostic tools for Mellanox
    manufactured HCA/NIC cards. It also provides access to the relevant source
    code. Please see the file LICENSE for licensing details.
endef
 
define Build/Configure
	$(call Build/Configure/Default,--disable-inband)
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	sed -i 's/#include <sys\/pci.h>/#include <linux\/pci.h>\ntypedef unsigned char u_int8_t;\ntypedef unsigned short u_int16_t;\ntypedef unsigned u_int32_t;\ntypedef uint64_t u_int64_t;\ntypedef char *caddr_t;\ntypedef unsigned char u_char;\ntypedef unsigned short u_short, ushort;\ntypedef unsigned u_int, uint;\ntypedef unsigned long u_long, ulong;\ntypedef long long quad_t;\ntypedef unsigned long long u_quad_t;/g' $(PKG_BUILD_DIR)/mtcr_ul/mtcr_ul_com.c
endef
 
define Package/mstflint/install
	cp -r $(PKG_INSTALL_DIR) $(1)
endef
 
$(eval $(call BuildPackage,mstflint))
