project('gcc-arm-none-eabi', 'c')

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

lib = static_library(
    'gcc_arm',
    objects: thumb_obj,
)

gcc_arm_dep = declare_dependency(
    link_with: lib,
)
