#include <kprintv.h>

void boot_main(void)
{
    kprintv("Hello, World!", 0x0F);
    for (;;) {}
}
