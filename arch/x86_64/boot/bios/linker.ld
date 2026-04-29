ENTRY(PM)
OUTPUT_FORMAT(elf32-i386)

SECTIONS
{
    . = 0x7F00;    /* boot2.asm flat binary occupies 0x7E00-0x7EFF */

    .text :
    {
        *(.text)
    }

    .data :
    {
        *(.data)
    }

    .rodata :
    {
        *(.rodata)
    }

    .bss :
    {
        *(.bss)
        *(COMMON)
    }

    /DISCARD/ :
    {
        *(.note.GNU-stack)
    }
}
