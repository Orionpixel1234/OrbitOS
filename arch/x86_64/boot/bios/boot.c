#define VGA_BASE  0xB8000
#define VGA_WHITE 0x0F00    /* white text on black background */

static void vga_print(const char *str)
{
    volatile unsigned short *vga = (volatile unsigned short *)VGA_BASE;
    while (*str) {
        *vga++ = (unsigned short)VGA_WHITE | (unsigned char)*str++;
    }
}

void boot_main(void)
{
    vga_print("Hello, World!");
    for (;;) {}
}
