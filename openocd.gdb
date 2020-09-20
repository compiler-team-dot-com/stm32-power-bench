# Assume openocd running on port 3333 (default).
# Example:
# `$ openocd -f interface/stlink-v2-1.cfg -f target/stm32f3x.cfg`
target extended-remote :3333

# Print demangled symbols:
set print asm-demangle on

# Got this from the Rust book. Not sure what the effect is but does not seem
# to do any harm:
monitor arm semihosting enable

# Load the binary provided via the command line.
# Example:
# `$ gdb -q -x openocd.gdb my.elf`
load

break HardFault_Handler
continue

# Other options:
#
# break NMI_Handler
# break MemManage_Handler
# break BusFault_Handler
# break UsageFault_Handler
# break SVC_Handler

# Example of a break at file:line:
#
# break SW4STM32/startup_stm32f303xc.s:94
# continue

# start the process but immediately halt the processor
# stepi
