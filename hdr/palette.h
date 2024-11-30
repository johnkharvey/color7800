;Palette.asm

	processor 6502
	;Palette equates

; HERO Palette
P0C1Init	equ	#$E1	; dark ninja suit
P0C2Init	equ	$44	; red ballcap
P0C3Init	equ	$5C	; Skin

; Underground palette
P1C1Init	equ	$24	; Rust
P1C2Init	equ	$04	; Dark Grey
P1C3Init	equ	$16	; Yellow (lightbulb)

; Street/bush palette (not used)
;P2C1Init	equ	$04	; grey
P2C1Init	equ	$84	; grey
;P2C2Init	equ	$0E	; white ; also used for Text
P2C2Init	equ	$3E	; white ; also used for Text
;P2C3Init	equ	$C4	; green
P2C3Init	equ	$54	; green

; Special
P3C1Init	equ	$82	; Blue - for spikes
P3C2Init	equ	$0E	; White ; also used for text
P3C3Init	equ	$B8	; Aqua - for spikes and emerald


; UnderGround/ Pitfall Harry's legs
P4C1Init	equ	$1C	; Yellow
P4C2Init	equ	$22	; Brown
P4C3Init	equ	$D2	; Dark Green

; Underground 2
P5C1Init	equ	$54	; purple
P5C2Init	equ	$68	; darker purple
P5C3Init	equ	$44	; lava red

; Pitfall Harry's top
P6C1Init	equ	$C8	; yellow green
P6C2Init	equ	$4A	; pink
P6C3Init	equ	$22	; brown


P7C1Init	equ	$00	; black - needed for Curtains
P7C2Init	equ	$08	; light grey
P7C3Init	equ	$0E	; white

	;NTSC to PAL color Macro
	mac	NTSC2PALColor
	;
	; ***********************************
	; Here is the color conversion table:
	; ***********************************
	;------------
	; NTSC   PAL
	;------------
	; $0x    $0x
	; $1x    $3x
	; $2x    $4x
	; $3x    $5x
	; $4x    $6x
	; $5x    $7x
	; $6x    $8x
	; $7x    $9x
	; $8x    $Ax
	; $9x    $Bx
	; $Ax    $Cx
	; $Bx    $Dx
	; $Cx    $EX
	; $Dx    $Fx
	; $Ex    $1x
	; $Fx    $2x
	;
	; ****************
	; Converter macro:
	; ****************
	if	([{1}]>>4 == $00)
		dc.b	[{1}]		; 0->0
		mexit
	endif
	if	([{1}]>>4 == $0E)
		dc.b	[{1}]-$D0	; E->1
		mexit
	endif

	if	([{1}]>>4 == $0F)
		dc.b	[{1}]-$D0	; F->2
	else
		dc.b	[{1}]+$20	; all else
	endif
	endm
