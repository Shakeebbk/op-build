################################################################################
#
# occ
#
################################################################################

OCC_VERSION ?= 7d74758c1ccb09a86510821cf8f6ed94a17c4ec3
OCC_SITE ?= $(call github,open-power,occ,$(OCC_VERSION))
OCC_LICENSE = Apache-2.0
OCC_DEPENDENCIES = host-binutils host-p8-pore-binutils

OCC_INSTALL_IMAGES = YES
OCC_INSTALL_TARGET = NO

OCC_STAGING_DIR = $(STAGING_DIR)/occ

define OCC_BUILD_CMDS
        cd $(@D)/src && \
        make POREPATH=$(P8_PORE_BINUTILS_BIN)/bin/ OCC_OP_BUILD=1 CROSS_PREFIX=$(TARGET_CROSS) all && \
        make combineImage
endef

define OCC_INSTALL_IMAGES_CMDS
       mkdir -p $(STAGING_DIR)/occ
       cp $(@D)/src/image.bin $(OCC_STAGING_DIR)/$(BR2_OCC_BIN_FILENAME)
endef

$(eval $(generic-package))
