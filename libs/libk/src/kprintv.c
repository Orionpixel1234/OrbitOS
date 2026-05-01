#include <kprintv.h>

static int cursor_row = 0;
static int cursor_col = 0;

void kprintv(const char *s, int color)
{
    unsigned int addr;
    volatile unsigned short *cell;

    while (*s) {
        if (*s == '\n') {
            cursor_col = 0;
            cursor_row++;
        } else {
            /* Compute cell address as a plain integer from the base macro,
               avoiding neutron's pointer-subscript codegen bug. */
            addr = VGA_ADDRESS + (unsigned int)(cursor_row * VGA_WIDTH + cursor_col) * 2;
            cell = (volatile unsigned short *)addr;
            *cell = (unsigned short)((color << 8) | (unsigned char)*s);
            cursor_col++;
            if (cursor_col >= VGA_WIDTH) {
                cursor_col = 0;
                cursor_row++;
            }
        }
        s++;
        if (cursor_row >= VGA_HEIGHT)
            cursor_row = 0;
    }
}
