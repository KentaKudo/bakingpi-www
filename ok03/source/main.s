/* With the help of the following threads */
/* https://github.com/Chadderz121/bakingpi-www/issues/12 */
/* https://www.raspberrypi.org/forums/viewtopic.php?f=72&t=114796 */
.section .init
.global _start
_start:

b main


.section .text
main:
mov sp,#0x8000

pinNum .req r0
pinFunc .req r1
mov pinNum,#47
mov pinFunc,#1
bl SetGpioFunction
.unreq pinNum
.unreq pinFunc

loop$:

pinNum .req r0
pinVal .req r1
mov pinNum,#47
mov pinVal,#0
bl SetGpio
.unreq pinNum
.unreq pinVal

mov r2,#0x3F0000
wait1$:
    sub r2,#1
    cmp r2,#0
    bne wait1$

pinNum .req r0
pinVal .req r1
mov pinNum,#47
mov pinVal,#1
bl SetGpio
.unreq pinNum
.unreq pinVal

mov r2,#0x3F0000
wait2$:
    sub r2,#1
    cmp r2,#0
    bne wait2$

b loop$
