LOCAL_PATH := $(call my-dir)

mips_codegen_TBLGEN_TABLES := \
  MipsGenRegisterInfo.inc \
  MipsGenInstrInfo.inc \
  MipsGenCodeEmitter.inc \
  MipsGenMCCodeEmitter.inc \
  MipsGenMCPseudoLowering.inc \
  MipsGenAsmWriter.inc \
  MipsGenDAGISel.inc \
  MipsGenFastISel.inc \
  MipsGenCallingConv.inc \
  MipsGenSubtargetInfo.inc

mips_codegen_SRC_FILES := $(sort $(notdir $(wildcard $(LOCAL_PATH)/*.cpp)))

# For the host
# =====================================================
include $(CLEAR_VARS)
include $(CLEAR_TBLGEN_VARS)

LOCAL_MODULE:= libLLVMMipsCodeGen
LOCAL_MODULE_HOST_OS := darwin linux windows

LOCAL_SRC_FILES := $(mips_codegen_SRC_FILES)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/MCTargetDesc

TBLGEN_TABLES := $(mips_codegen_TBLGEN_TABLES)

include $(LLVM_HOST_BUILD_MK)
include $(LLVM_TBLGEN_RULES_MK)
include $(LLVM_GEN_ATTRIBUTES_MK)
include $(LLVM_GEN_INTRINSICS_MK)
include $(BUILD_HOST_STATIC_LIBRARY)

# For the device only
# =====================================================
ifneq (true,$(DISABLE_LLVM_DEVICE_BUILDS))
include $(CLEAR_VARS)
include $(CLEAR_TBLGEN_VARS)

LOCAL_MODULE:= libLLVMMipsCodeGen

LOCAL_SRC_FILES := $(mips_codegen_SRC_FILES)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/MCTargetDesc

TBLGEN_TABLES := $(mips_codegen_TBLGEN_TABLES)

include $(LLVM_DEVICE_BUILD_MK)
include $(LLVM_TBLGEN_RULES_MK)
include $(LLVM_GEN_ATTRIBUTES_MK)
include $(LLVM_GEN_INTRINSICS_MK)
include $(BUILD_STATIC_LIBRARY)
endif
