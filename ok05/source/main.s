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

ptrn .req r4
ldr ptrn,=pattern
ldr ptrn,[ptrn]
seq .req r5
mov seq,#0

loop$:

mov r0,#47
mov r1,#1
lsl r1,seq
and r1,ptrn
bl SetGpio

ldr r0,=250000
bl Wait

add seq,#1
and seq,#0b11111
b loop$

.section .data
.align 2
pattern:
.int 0x11111111101010100010001000101010
