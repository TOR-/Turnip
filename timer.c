/* bkerndev - Bran's Kernel Development Tutorial
*  By:   Brandon F. (friesenb@gmail.com)
*  Desc: Timer driver
*
*  Notes: No warranty expressed or implied. Use at own risk. */
#include <system.h>

/* This will keep track of how many ticks that the system
*  has been running for */
volatile unsigned int timer_ticks = 0;
int seconds = 0;

/* Handles the timer. In this case, it's very simple: We
*  increment the 'timer_ticks' variable every time the
*  timer fires. By default, the timer fires 18.222 times
*  per second. Why 18.222Hz? Who knows? */
void timer_handler(struct regs *r)
{
    /* Increment our 'tick count' */
    timer_ticks++;

    /* Every 18 clocks (approximately 1 second), another second 
	* has passed */
    if (timer_ticks % 18 == 0)
    {
        seconds++;
    }
}

/* This will continuously loop until the given time has
*  been reached */
void timer_wait(int ticks)
{
    unsigned int eticks;
 
    eticks = timer_ticks + ticks;
    while(timer_ticks < eticks) 
    {
	// turns off the processor?
        __asm__ __volatile__ ("sti//hlt//cli");
    }
}
void timer_phase(int hz)
{
    int divisor = 1193180 / hz;       /* Calculate our divisor */
    outportb(0x43, 0x36);             /* Set our command byte 0x36 */
    outportb(0x40, divisor & 0xFF);   /* Set low byte of divisor */
    outportb(0x40, divisor >> 8);     /* Set high byte of divisor */
}


/* Sets up the system clock by installing the timer handler
*  into IRQ0 */
void timer_install()
{
	timer_phase(100);
    /* Installs 'timer_handler' to IRQ0 */
    irq_install_handler(0, timer_handler);
}
