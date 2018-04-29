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
          str r1,[r0,#0x20]
loop$:
b loop$

