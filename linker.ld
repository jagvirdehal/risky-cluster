MEMORY {
	FLASH (rx) : ORIGIN =  0x8000000, LENGTH = 16K
	RAM  (xrw) : ORIGIN = 0x20000000, LENGTH = 2K
}

SECTIONS {
	/* FLASH */
	.text.boot : {
		KEEP(*(.text.boot))
	} >FLASH
	.text : {
		KEEP(*(.text*))
	} >FLASH


	/* RAM */
	.rodata : {
		KEEP(*(.rodata*))
	} >RAM
	.data : {
		KEEP(*(.data*))
	} >RAM
	.bss : {
		KEEP(*(.bss*))
	} >RAM

	/* Define BSS start & end to be cleared */
	__bss_start = ADDR(.bss);
	__bss_end = ADDR(.bss) + SIZEOF(.bss);
}
