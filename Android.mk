#
# Copyright (C) 2023 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),fuxi)
	include $(call all-makefiles-under,$(LOCAL_PATH))
	include $(CLEAR_VARS)

# A/B builds require us to create the mount points at compile time.
FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/firmware_mnt
$(FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/firmware_mnt

BT_FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/bt_firmware
$(BT_FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(BT_FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/bt_firmware

DSP_MOUNT_POINT := $(TARGET_OUT_VENDOR)/dsp
$(DSP_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(DSP_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/dsp

VM_SYSTEM_MOUNT_POINT := $(TARGET_OUT_VENDOR)/vm-system
$(VM_SYSTEM_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(VM_SYSTEM_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/vm-system

ALL_DEFAULT_INSTALLED_MODULES += \
	$(FIRMWARE_MOUNT_POINT) \
	$(BT_FIRMWARE_MOUNT_POINT) \
	$(DSP_MOUNT_POINT) \
	$(VM_SYSTEM_MOUNT_POINT)

CAMERA_LIB_SYMLINKS := $(TARGET_OUT_VENDOR)/lib64/camera
$(CAMERA_LIB_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating camera lib64 symlink: $@"
	@mkdir -p $@
	$(hide) ln -sf /odm/lib64/camera/aon_front.pb $@/aon_front.pb

ALL_DEFAULT_INSTALLED_MODULES += \
	$(CAMERA_LIB_SYMLINKS)

IMS_LIBS := libimscamera_jni.so libimsmedia_jni.so
IMS_SYMLINKS := $(addprefix $(TARGET_OUT_SYSTEM_EXT_APPS_PRIVILEGED)/ims/lib/arm64/,$(notdir $(IMS_LIBS)))
$(IMS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "IMS lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system_ext/lib64/$(notdir $@) $@

CNE_LIBS := libvndfwk_detect_jni.qti_vendor.so
CNE_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR_APPS)/CneApp/lib/arm64/,$(notdir $(CNE_LIBS)))
$(CNE_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "CNE lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/lib64/$(notdir $@) $@

EGL_LIB64_SYMLINKS := $(TARGET_OUT_VENDOR)/lib64
$(EGL_LIB64_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "EGL lib64 symlinks: $@"
	@mkdir -p $@
	$(hide) ln -sf egl/libEGL_adreno.so $@/libEGL_adreno.so
	$(hide) ln -sf egl/libGLESv2_adreno.so $@/libGLESv2_adreno.so
	$(hide) ln -sf egl/libq3dtools_adreno.so $@/libq3dtools_adreno.so

ALL_DEFAULT_INSTALLED_MODULES += \
	$(CNE_SYMLINKS) \
	$(IMS_SYMLINKS) \
	$(EGL_LIB_SYMLINKS) \
	$(EGL_LIB64_SYMLINKS)

FIRMWARE_WLAN_QCA_CLD_KIWI_SYMLINKS := $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld/kiwi/
$(FIRMWARE_WLAN_QCA_CLD_KIWI_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating kiwi qca_cld wlan firmware symlinks: $@"
	mkdir -p $@
	$(hide) ln -sf /vendor/etc/wifi/kiwi/WCNSS_qcom_cfg.ini $@/WCNSS_qcom_cfg.ini
	$(hide) ln -sf /mnt/vendor/persist/kiwi/wlan_mac.bin $@/wlan_mac.bin

FIRMWARE_WLAN_QCA_CLD_KIWI_V2_SYMLINKS := $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld/kiwi_v2/
$(FIRMWARE_WLAN_QCA_CLD_KIWI_V2_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating kiwi_v2 qca_cld wlan firmware symlinks: $@"
	mkdir -p $@
	$(hide) ln -sf /vendor/etc/wifi/kiwi_v2/WCNSS_qcom_cfg.ini $@/WCNSS_qcom_cfg.ini
	$(hide) ln -sf /mnt/vendor/persist/kiwi_v2/wlan_mac.bin $@/wlan_mac.bin

FIRMWARE_WLAN_QCA_CLD_QCA6490_SYMLINKS := $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld/qca6490/
$(FIRMWARE_WLAN_QCA_CLD_QCA6490_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating qca6490 qca_cld wlan firmware symlinks: $@"
	mkdir -p $@
	$(hide) ln -sf /vendor/etc/wifi/qca6490/WCNSS_qcom_cfg.ini $@/WCNSS_qcom_cfg.ini
	$(hide) ln -sf /mnt/vendor/persist/qca6490/wlan_mac.bin $@/wlan_mac.bin

ALL_DEFAULT_INSTALLED_MODULES += \
	$(FIRMWARE_WLAN_QCA_CLD_KIWI_SYMLINKS) \
	$(FIRMWARE_WLAN_QCA_CLD_KIWI_V2_SYMLINKS) \
	$(FIRMWARE_WLAN_QCA_CLD_QCA6490_SYMLINKS)

FIRMWARE_SYMLINKS := $(TARGET_OUT_VENDOR)/firmware/
$(FIRMWARE_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating wlanmdsp.otaupdate firmware symlinks: $@"
	mkdir -p $@
	$(hide) ln -sf /data/vendor/firmware/wlanmdsp.mbn $@/wlanmdsp.otaupdate

ALL_DEFAULT_INSTALLED_MODULES += \
	$(FIRMWARE_SYMLINKS)

endif
