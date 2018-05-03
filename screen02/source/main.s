.section .init
.global _start
_start:

b main


.section .text
main:
    mov sp,#0x8000

    mov r0,#1024
    mov r1,#768
    mov r2,#16
    bl InitialiseFrameBuffer

    teq r0,#0
    bne noError$

    mov r0,#47
    mov r1,#1
    bl SetGpioFunction

    mov r0,#47
    mov r1,#0
    bl SetGpio

    error$:
        b error$

    noError$:

    fbInfoAddr .req r4
    mov fbInfoAddr,r0

    bl SetGraphicsAddress

    lastRandom .req r7
    lastX .req r8
    lastY .req r9
    colour .req r10
    x .req r5
    y .req r6
    mov lastRandom,#0
    mov lastX,#0
    mov lastY,#0
    mov colour,#0

render$:
    mov r0,lastRandom
    bl Random
    mov x,r0
    bl Random
    mov y,r0
    mov lastRandom,r0

    mov r0,colour
    add colour,#1
    lsl colour,#16
    lsr colour,#16
    bl SetForeColour

    mov r0,lastX
    mov r1,lastY
    lsr r2,x,#22
    lsr r3,y,#22

    cmp r3,#768
    bhs render$

    mov lastX,r2
    mov lastY,r3
    
    bl DrawLine

    b render$

    .unreq x
    .unreq y
    .unreq lastRandom
    .unreq lastX
    .unreq lastY
    .unreq colour
