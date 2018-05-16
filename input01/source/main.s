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

    bl UsbInitialise

    mov r4,#0
    mov r5,#0
loopContinue$:
    bl KeyboardUpdate
    bl KeyboardGetChar

    teq r0,#0
    beq loopContinue$

    mov r1,r4
    mov r2,r5
    bl DrawCharacter

    add r4,r0

    teq r4,#1024
    addeq r5,r1
    moveq r4,#0
    teqeq r5,#768
    moveq r5,#0

    b loopContinue$
