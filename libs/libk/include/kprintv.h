#ifndef KPRINTV_H
#define KPRINTV_H

#define VGA_ADDRESS 0xB8000
#define VGA_WIDTH   80
#define VGA_HEIGHT  25

void kprintv(const char *s, int color);

#endif
