project('stm32_power_bench', ['c'], meson_version: '>=0.55.0')

src_path = 'Src'
cube_path = 'STM32Cube_FW_F3_V1.11.1'
cube_drivers = cube_path / 'Drivers'
bsp_path = cube_drivers / 'BSP/STM32F3-Discovery'
hal_path = cube_drivers / 'STM32F3xx_HAL_Driver/Src'

# Array populated below.
c_args = []

thumb_path = 'gcc-arm-none-eabi-9-2020-q2-update/lib/gcc' /\
    'arm-none-eabi/9.3.1/thumb/v7e-m+fp/hard'
thumb_obj = files(
    thumb_path / 'crtbegin.o',
    thumb_path / 'crtend.o',
    thumb_path / 'crtfastmath.o',
    thumb_path / 'crti.o',
    thumb_path / 'crtn.o',
    thumb_path / 'libgcc.a',
    thumb_path / 'libgcov.a',
)

src_files = files(
    src_path / 'main.c',
    src_path / 'stm32f3xx_it.c',
    src_path / 'stm32f3xx_hal_msp.c',
    src_path / 'stm32f3xx_lp_modes.c',
    src_path / 'system_stm32f3xx.c',
)

asm_files = files('SW4STM32/startup_stm32f303xc.s')
bsp_files = files(bsp_path / 'stm32f3_discovery.c')

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
    hal_path / 'stm32f3xx_hal_exti.c',
)

sources = [
    src_files,
    asm_files,
    bsp_files,
    hal_files,
]

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

if get_option('debug') == true
    # By default, Meson takes care of "-g".
    c_args += ['-gdwarf-2']
endif

# "-D" directives.
# These are required by the ARM drivers, and they will fail to compile
# if you do not make those choices. Look for the pre-processor directives
# in their sources.
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

link_args = [

    # Reject shared libs.
    '-Bstatic',

    # Load libraries.
    '-lc',
    '-lm',
    '-lnosys',

    # Remove unused sections, if you can, please.
    '-Wl,--gc-sections',

    # Only use library directories specified on the command line.
    # While the LLVM toolchain does not include any C standard library when
    # linking for bare matal, the ARM GCC does.
    #
    # When I take of them by myself the configuration feels more regular
    # between toolchains.
    '-nodefaultlibs',
    '-nostdlib',
]

# Map host_machine.system => path to linker script.
link_scripts = {
    'stm32': meson.current_source_dir() / 'SW4STM32/STM32F3-Discovery/STM32F303VCTx_FLASH.ld',
    'qemu': meson.current_source_dir() / '',
}
link_args += ['-Wl,--script=' + link_scripts[host_machine.system()]]

executable(
    'stm32_power_bench',
    sources: sources,
    objects: thumb_obj,
    include_directories: inc,
    c_args: c_args,
    link_args: link_args,
)
