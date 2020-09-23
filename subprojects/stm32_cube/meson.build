project('stm32_cube', 'c')

gcc_arm_sp = subproject('gcc-arm-none-eabi', required: true)
gcc_arm_dep = gcc_arm_sp.get_variable('gcc_arm_dep')

cube_drivers = 'STM32Cube_FW_F3_V1.11.1/Drivers'
bsp_path = cube_drivers / 'BSP/STM32F3-Discovery'
hal_path = cube_drivers / 'STM32F3xx_HAL_Driver/Src'

inc = include_directories(
    'Inc',
    cube_drivers / 'STM32F3xx_HAL_Driver/Inc',
    cube_drivers / 'STM32F3xx_HAL_Driver/Inc/Legacy',
    cube_drivers / 'CMSIS/Device/ST/STM32F3xx/Include',
    cube_drivers / 'CMSIS/Include',
    cube_drivers / 'BSP/STM32F3-Discovery',
    cube_drivers / 'BSP/Components/Common',
    cube_drivers / 'CMSIS/Include',
)

src = files(
    bsp_path / 'stm32f3_discovery.c',

    hal_path / 'stm32f3xx_hal_rtc.c',
    hal_path / 'stm32f3xx_hal_rtc_ex.c',
    hal_path / 'stm32f3xx_hal_tim.c',
    hal_path / 'stm32f3xx_hal_tim_ex.c',
    hal_path / 'stm32f3xx_hal.c',
    hal_path / 'stm32f3xx_hal_rcc.c',
    hal_path / 'stm32f3xx_hal_rcc_ex.c',
    hal_path / 'stm32f3xx_hal_gpio.c',
    hal_path / 'stm32f3xx_hal_dma.c',
    hal_path / 'stm32f3xx_hal_cortex.c',
    hal_path / 'stm32f3xx_hal_pwr.c',
    hal_path / 'stm32f3xx_hal_pwr_ex.c',
    hal_path / 'stm32f3xx_hal_flash.c',
    hal_path / 'stm32f3xx_hal_flash_ex.c',
    hal_path / 'stm32f3xx_hal_i2c.c',
    hal_path / 'stm32f3xx_hal_i2c_ex.c',
    hal_path / 'stm32f3xx_hal_exti.c',
)

c_args = []

c_args += [
    '-DUSE_HAL_DRIVER',
    '-DSTM32F303xC',
]

c_args += [
    '-mthumb',
    '-mcpu=' + host_machine.cpu(),
    '-mfpu=' + meson.get_cross_property('fpu'),
    '-mfloat-abi=' + meson.get_cross_property('float_abi'),
    '-fdata-sections',
    '-ffunction-sections',
]

lib = static_library(
    'stm32_cube', 
    src,
    c_args: c_args,
    include_directories: inc,
    dependencies: gcc_arm_dep,
)

cube_dep = declare_dependency(
    # This include allows the parent project to include headers from this
    # subproject.
    include_directories: inc,
    link_with: lib,
)
