[BITS 16]
[ORG 0x7E00]

main:
    CLI

    ; Enable A20 via BIOS INT 15h, AX=2401h
    MOV AX, 0x2401
    INT 0x15
    JNC .a20_done

    ; Fast A20: port 0x92, set bit 1, clear bit 0 (bit 0 = system reset)
    IN  AL, 0x92
    OR  AL, 0x02
    AND AL, 0xFE
    OUT 0x92, AL
.a20_done:

    ; Patch GDT base with the physical address of gdt_start
    MOV EAX, gdt_start
    MOV [gdt_descriptor + 2], EAX
    LGDT [gdt_descriptor]

    ; Switch to protected mode
    MOV EAX, CR0
    OR  EAX, 1
    MOV CR0, EAX

    ; Far jump to 32-bit PM entry at fixed address 0x7F00
    ; CODE_SEG selector = 0x08 (gdt_code - gdt_start)
    JMP 0x08:0x7F00

; ── GDT ──────────────────────────────────────────────────────────────────────

gdt_start:
    DQ 0x0000000000000000       ;; Null descriptor

gdt_code:
    DW 0xFFFF                   ;; Limit [0:15]
    DW 0x0000                   ;; Base  [0:15]
    DB 0x00                     ;; Base  [16:23]
    DB 10011010b                ;; Access: present, ring 0, code, exec/read
    DB 11001111b                ;; Flags: 4KB gran, 32-bit; Limit [16:19]
    DB 0x00                     ;; Base  [24:31]

gdt_data:
    DW 0xFFFF
    DW 0x0000
    DB 0x00
    DB 10010010b                ;; Access: present, ring 0, data, read/write
    DB 11001111b
    DB 0x00

gdt_end:

gdt_descriptor:
    DW gdt_end - gdt_start - 1 ;; GDT size minus 1
    DD 0x00000000               ;; GDT base (patched at runtime above)

;; Pad to exactly 256 bytes so the 32-bit PM code lands at 0x7F00
TIMES 0x100-($-$$) DB 0
