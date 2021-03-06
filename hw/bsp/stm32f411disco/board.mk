CFLAGS += \
  -DHSE_VALUE=8000000 \
  -DCFG_TUSB_MCU=OPT_MCU_STM32F4 \
  -DSTM32F411xE \
  -mthumb \
  -mabi=aapcs-linux \
  -mcpu=cortex-m4 \
  -mfloat-abi=hard \
  -mfpu=fpv4-sp-d16 \
  -nostdlib -nostartfiles

# All source paths should be relative to the top level.
LD_FILE = hw/bsp/stm32f411disco/STM32F411VETx_FLASH.ld

SRC_C += \
	hw/mcu/st/system-init/system_stm32f4xx.c \
	hw/mcu/st/stm32lib/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c \
	hw/mcu/st/stm32lib/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c \
	hw/mcu/st/stm32lib/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c \
	hw/mcu/st/stm32lib/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c

SRC_S += \
	hw/mcu/st/startup/stm32f4/startup_stm32f411xe.s

INC += \
	$(TOP)/hw/mcu/st/cmsis \
	$(TOP)/hw/mcu/st/stm32lib/CMSIS/STM32F4xx/Include \
	$(TOP)/hw/mcu/st/stm32lib/STM32F4xx_HAL_Driver/Inc \
	$(TOP)/hw/bsp/stm32f411disco

# For TinyUSB port source
VENDOR = st
CHIP_FAMILY = stm32f4

# For freeRTOS port source
FREERTOS_PORT = ARM_CM4F

# For flash-jlink target
JLINK_DEVICE = stm32f41ve
JLINK_IF = swd

# Path to STM32 Cube Programmer CLI, should be added into system path 
STM32Prog = STM32_Programmer_CLI

# flash target using on-board stlink
flash: $(BUILD)/$(BOARD)-firmware.elf
	$(STM32Prog) --connect port=swd --write $< --go
