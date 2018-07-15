include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-config-mode-notify
PKG_VERSION:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include ../gluon.mk

PKG_CONFIG_DEPENDS += $(GLUON_I18N_CONFIG)


define Package/gluon-config-mode-notify
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=Allows the user to select if they want to be notified about problems with this node
  DEPENDS:=+gluon-config-mode-core +gluon-node-info
endef

define Package/gluon-config-mode-notify/description
	Allows the user to select if they want to be notified about problems with this node.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
	$(call GluonBuildI18N,gluon-config-mode-notify,i18n)
	$(call GluonSrcDiet,./luasrc,$(PKG_BUILD_DIR)/luadest/)
endef

define Package/gluon-config-mode-notify/install
	$(CP) $(PKG_BUILD_DIR)/luadest/* $(1)/
	$(call GluonInstallI18N,gluon-config-mode-notify,$(1))
endef

define Package/gluon-config-mode-notify/postinst
#!/bin/sh
$(call GluonCheckSite,check_site.lua)
endef

$(eval $(call BuildPackage,gluon-config-mode-notify))
