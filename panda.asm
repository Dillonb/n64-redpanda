arch n64.cpu
output panda.z64
endian msb
fill 1052672

origin $00000000
base $80000000

constant PANDA_SIZE(640 * 480 * 4)
constant fb_origin($A0100000)
constant SCREEN_X(640)
constant SCREEN_Y(480)
constant vi_origin($A0100000)

include "lib/n64.inc"
include "lib/header.inc"
insert "lib/bootcode.bin"
include "lib/n64_gfx.inc"

Start:
    N64_INIT()
    ScreenNTSC(SCREEN_X, SCREEN_Y, BPP32, vi_origin)
    li t0, 0xA4600000 // PI regs base address

    // PI_DRAM_ADDR
    la t1, fb_origin
    sw t1, 0(t0)

    // PI_CART_ADDR
    li t1, (Panda - 0x70000000)
    sw t1, 4(t0)

    // PI_WR_LEN
    li t1, ((640 * 480 * 4) - 1)
    sw t1, 0xC(t0) // Starts DMA

WaitPIDMA:
    // Wait for DMA to complete
    lw t1, 0x10(t0) // PI_STATUS
    andi t1, t1, 1
    bnez t1, WaitPIDMA
    nop

Hang:
    j Hang
    nop

align(4)
insert Panda, "panda.bin"
