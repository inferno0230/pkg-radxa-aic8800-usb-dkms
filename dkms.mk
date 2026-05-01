DKMS_BUILD_DIR ?= $(CURDIR)

.NOTPARALLEL:
.PHONY: all clean aic8800 aic_btusb

all: aic8800 aic_btusb

aic8800:
	$(MAKE) -C $(KERNEL_SOURCE_DIR) M=$(DKMS_BUILD_DIR)/USB/driver_fw/drivers/aic8800

aic_btusb:
	$(MAKE) -C $(KERNEL_SOURCE_DIR) M=$(DKMS_BUILD_DIR)/USB/driver_fw/drivers/aic_btusb

clean:
	$(MAKE) -C $(KERNEL_SOURCE_DIR) M=$(DKMS_BUILD_DIR)/USB/driver_fw/drivers/aic8800 clean
	$(MAKE) -C $(KERNEL_SOURCE_DIR) M=$(DKMS_BUILD_DIR)/USB/driver_fw/drivers/aic_btusb clean
