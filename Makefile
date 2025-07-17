include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-ipinfo
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-ipinfo
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=IP Info
  DEPENDS:=+luci-base +luci-lib-jsonc +curl
  PKGARCH:=all
endef

define Package/luci-app-ipinfo/description
  LuCI application to display IP information using 2ip.ru API.
endef

define Build/Prepare
  mkdir -p $(PKG_BUILD_DIR)
  $(CP) ./luasrc $(PKG_BUILD_DIR)/
  $(CP) ./htdocs $(PKG_BUILD_DIR)/
endef

define Package/luci-app-ipinfo/install
  $(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
  $(INSTALL_DATA) $(PKG_BUILD_DIR)/luasrc/controller/ipinfo.lua $(1)/usr/lib/lua/luci/controller/
  $(INSTALL_DIR) $(1)/www/luci-static/resources/view
  $(INSTALL_DATA) $(PKG_BUILD_DIR)/htdocs/luci-static/resources/view/ipinfo.htm $(1)/www/luci-static/resources/view/
endef

$(eval $(call BuildPackage,luci-app-ipinfo))
