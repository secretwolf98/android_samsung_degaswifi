$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) \
		$(recovery_ramdisk) \
		$(recovery_kernel)
	@echo -e ${CL_CYN}"----- Making recovery image ------"${CL_RST}
	@echo -e "$(BOARD_CUSTOM_MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@"
	$(hide) $(BOARD_CUSTOM_MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES)
	@echo -e ${CL_CYN}"----- Making kernel image ------"${CL_RST}
	@echo -e "$(BOARD_CUSTOM_MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@"
	$(hide) $(BOARD_CUSTOM_MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}
