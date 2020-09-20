project(
    'stm32_power_bench',
    ['c'],
    meson_version: '>=0.55.0'
)

src_path = 'Src'
cube_path = 'STM32Cube_FW_F3_V1.11.1'
bsp_path = cube_path / 'Drivers/BSP/STM32F3-Discovery'
hal_path = cube_path / 'Drivers/STM32F3xx_HAL_Driver/Src'

thumb_obj = [
    '/home/centos/gcc-arm-none-eabi-9-2020-q2-update/lib/gcc/arm-none-eabi/9.3.1/thumb/v7e-m+fp/hard/crtbegin.o',
    '/home/centos/gcc-arm-none-eabi-9-2020-q2-update/lib/gcc/arm-none-eabi/9.3.1/thumb/v7e-m+fp/hard/crtend.o',
    '/home/centos/gcc-arm-none-eabi-9-2020-q2-update/lib/gcc/arm-none-eabi/9.3.1/thumb/v7e-m+fp/hard/crtfastmath.o',
    '/home/centos/gcc-arm-none-eabi-9-2020-q2-update/lib/gcc/arm-none-eabi/9.3.1/thumb/v7e-m+fp/hard/crti.o',
    '/home/centos/gcc-arm-none-eabi-9-2020-q2-update/lib/gcc/arm-none-eabi/9.3.1/thumb/v7e-m+fp/hard/crtn.o',
    '/home/centos/gcc-arm-none-eabi-9-2020-q2-update/lib/gcc/arm-none-eabi/9.3.1/thumb/v7e-m+fp/hard/libgcc.a',
    '/home/centos/gcc-arm-none-eabi-9-2020-q2-update/lib/gcc/arm-none-eabi/9.3.1/thumb/v7e-m+fp/hard/libgcov.a'
]

src_files = files(
    src_path / 'main.c',
    src_path / 'stm32f3xx_it.c',
    src_path / 'stm32f3xx_hal_msp.c',
    src_path / 'stm32f3xx_lp_modes.c',
    src_path / 'system_stm32f3xx.c'
)

asm_files = files(
    'SW4STM32/startup_stm32f303xc.s'
)

bsp_files = files(
    bsp_path / 'stm32f3_discovery.c'
)

hal_files = files(
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
    hal_path / 'stm32f3xx_hal_exti.c'
)

sources = [
    src_files,
    asm_files,
    bsp_files,
    hal_files
]

executable('stm32_power_bench', sources, objects: thumb_obj)
