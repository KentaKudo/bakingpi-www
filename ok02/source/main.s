/* With the help of the following threads */
/* https://github.com/Chadderz121/bakingpi-www/issues/12 */
/* https://www.raspberrypi.org/forums/viewtopic.php?f=72&t=114796 */
.section .init
.global _start
_start:

ldr r0,=0x20200000
mov r1,#1
lsl r1,#21
str r1,[r0,#16] /* ACT is moved to 47th pin */

mov r1,#1
lsl r1,#15 /* use GPSET1 instead of GPSET0 */

loop$:

str r1,[r0,#0x20]

mov r2,#0x3F0000
wait1$:
    sub r2,#1
    cmp r2,#0
    bne wait1$

str r1,[r0,#0x2c] /* GPCLR1 instead of CPCLR0 */

mov r2,#0x3F0000
wait2$:
    sub r2,#1
    cmp r2,#0
    bne wait2$

b loop$

