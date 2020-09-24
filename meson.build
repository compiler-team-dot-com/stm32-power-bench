project(
    'stm32_power_bench', ['c'], meson_version: '>=0.55.0',
    version: run_command('head', 
        meson.source_root() / 'VERSION').stdout().strip(),
)

compiler_native = meson.get_compiler('c', native: true)
compiler_cross = meson.get_compiler('c', native: false)

src_path = 'Src'
c_args = []

cube_prj = subproject('stm32_cube', required: true)
cube_dep = cube_prj.get_variable('cube_dep')

gcc_arm_prj = subproject('gcc-arm-none-eabi', required: true)
gcc_arm_dep = gcc_arm_prj.get_variable('gcc_arm_dep')

src_files = files(
    src_path / 'main.c',
    src_path / 'stm32f3xx_it.c',
    src_path / 'stm32f3xx_lp_modes.c',
    src_path / 'system_stm32f3xx.c',
)

# Map host_machine.system => path to startup assembly.
startup_asms = {
    'stm32': 'SW4STM32/startup_stm32f303xc.s',
    'qemu': '',
}
startup_asm = startup_asms[meson.get_cross_property('env')]
summary('Startup assembly', startup_asm, section: 'Files')

sources = [
    src_files,
    files(startup_asm),
]

summary('Debug', get_option('debug'), section: 'Flags')
if get_option('debug') == true
    # By default, Meson takes care of "-g".
    c_args += ['-gdwarf-2']
endif

# "-D" directives.
# These are required by the ARM drivers, and they will fail to compile
# if you do not make those choices. Look for the pre-processor directives
# in their sources.
config_data = configuration_data()
config_data.set('USE_HAL_DRIVER', true)
config_data.set('STM32F303xC', true)
config_file = configure_file(
    output: 'config.h',
    configuration: config_data,
)
config_inc = include_directories('.')

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
    # '-lm',
    # '-lnosys',

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
link_script = link_scripts[meson.get_cross_property('env')]
link_args += ['-Wl,--script=' + link_script]
summary('Link script', link_script, section: 'Files')

elf = executable(
    'stm32_power_bench',
    sources: sources,
    include_directories: [
        include_directories('Inc'),
        config_inc,
    ],
    c_args: c_args,
    link_args: link_args,
    dependencies: [cube_dep, gcc_arm_dep],
)

test_script = find_program('tester.sh')
test('qemu_boots', test_script, args: [elf])

flasher = find_program('STM32_Programmer_CLI')
run_target('flash', command: [flasher, '-c', 'port=SWD', '-d', elf])

summary('Native compiler ' + compiler_native.get_id(), compiler_native.version(), section: 'Versions')
summary('Cross compiler ' + compiler_cross.get_id(), compiler_cross.version(), section: 'Versions')
