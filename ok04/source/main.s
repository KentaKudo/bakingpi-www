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

time .req r0
mov r0,#0x100000
bl Wait
.unreq time

pinNum .req r0
pinVal .req r1
mov pinNum,#47
mov pinVal,#1
bl SetGpio
.unreq pinNum
.unreq pinVal

time .req r0
mov r0,#0x100000
bl Wait
.unreq time

b loop$
