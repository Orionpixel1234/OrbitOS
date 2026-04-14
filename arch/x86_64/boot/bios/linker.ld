ENTRY(main)
OUTPUT_FORMAT(elf32-i386)

SECTIONS
{
    . = 0x7E00;

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
