; Color v1.0 for the Atari 7800
; by John Harvey

; The system vectors are:
;     
;   INTERRUPT:		$EB1C
;   STARTUP:		$EB49
;   BRK-instruction:	$D4A5

; Graphic equates
GRAPHICS_SPACE	EQU $00	; a null character graphic pointer

; Control equates
Latch		EQU	$2200
COLOR		EQU	$2201
LEFTCOLOR	EQU	$2202	; used in DL's
RIGHTCOLOR	EQU	$2203	; used in DL's

	include MARIA.H

	SEG	keytest-code
        ORG     $8000

; graphics data for 128 characters - line 8
	dc.b	$00,$7E,$7E,$00,$00,$7C,$7C,$00
	dc.b	$FF,$00,$FF,$78,$18,$E0,$C0,$99
	dc.b	$00,$00,$18,$00,$00,$78,$00,$FF
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$60,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$60,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$FF
	dc.b	$00,$00,$00,$00,$00,$00,$00,$F8
	dc.b	$00,$00,$78,$00,$00,$00,$00,$00
	dc.b	$F0,$1E,$00,$00,$00,$00,$00,$00
	dc.b	$00,$F8,$00,$00,$00,$00,$00,$00
        
	ALIGN	256
; graphics data for 128 characters - line 7
	dc.b	$00,$81,$FF,$10,$10,$38,$38,$00
	dc.b	$FF,$3C,$C3,$CC,$7E,$F0,$E6,$5A
	dc.b	$80,$02,$3C,$66,$1B,$CC,$7E,$18
	dc.b	$18,$18,$00,$00,$00,$00,$00,$00
	dc.b	$00,$30,$00,$6C,$30,$C6,$76,$00
	dc.b	$18,$60,$00,$00,$30,$00,$30,$80
	dc.b	$7C,$FC,$FC,$78,$1E,$78,$78,$30
	dc.b	$78,$70,$30,$30,$18,$00,$60,$30
	dc.b	$78,$CC,$FC,$3C,$F8,$FE,$F0,$3E
	dc.b	$CC,$78,$78,$E6,$FE,$C6,$C6,$38
	dc.b	$F0,$1C,$E6,$78,$78,$FC,$30,$C6
	dc.b	$C6,$78,$FE,$78,$02,$78,$00,$00
	dc.b	$00,$76,$DC,$78,$76,$78,$F0,$0C
	dc.b	$E6,$78,$CC,$E6,$78,$C6,$CC,$78
	dc.b	$60,$0C,$F0,$F8,$18,$76,$30,$6C
	dc.b	$C6,$0C,$FC,$1C,$18,$E0,$00,$FE

	ALIGN	256
; graphics data for 128 characters - line 6
	dc.b	$00,$99,$E7,$38,$38,$7C,$7C,$18
	dc.b	$E7,$66,$99,$CC,$18,$70,$67,$3C
	dc.b	$E0,$0E,$7E,$00,$1B,$38,$7E,$3C
	dc.b	$18,$3C,$18,$30,$FE,$24,$FF,$18
	dc.b	$00,$00,$00,$6C,$F8,$66,$CC,$00
	dc.b	$30,$30,$66,$30,$30,$00,$30,$C0
	dc.b	$E6,$30,$CC,$CC,$0C,$CC,$CC,$30
	dc.b	$CC,$18,$30,$30,$30,$FC,$30,$00
	dc.b	$C0,$CC,$66,$66,$6C,$62,$60,$66
	dc.b	$CC,$30,$CC,$66,$66,$C6,$C6,$6C
	dc.b	$60,$78,$66,$CC,$30,$CC,$78,$EE
	dc.b	$6C,$30,$66,$60,$06,$18,$00,$00
	dc.b	$00,$CC,$66,$CC,$CC,$C0,$60,$7C
	dc.b	$66,$30,$CC,$6C,$30,$D6,$CC,$CC
	dc.b	$7C,$7C,$60,$0C,$34,$CC,$78,$FE
	dc.b	$6C,$7C,$64,$30,$18,$30,$00,$C6

	ALIGN	256
; graphics data for 128 characters - line 5
	dc.b	$00,$BD,$C3,$7C,$7C,$FE,$FE,$3C
	dc.b	$C3,$42,$BD,$CC,$3C,$30,$63,$E7
	dc.b	$F8,$3E,$18,$66,$1B,$6C,$7E,$7E
	dc.b	$18,$7E,$0C,$60,$C0,$66,$FF,$3C
	dc.b	$00,$30,$00,$FE,$0C,$30,$DC,$00
	dc.b	$60,$18,$3C,$30,$00,$00,$00,$60
	dc.b	$F6,$30,$60,$0C,$FE,$0C,$CC,$30
	dc.b	$CC,$0C,$00,$00,$60,$00,$18,$30
	dc.b	$DE,$FC,$66,$C0,$66,$68,$68,$CE
	dc.b	$CC,$30,$CC,$6C,$62,$D6,$CE,$C6
	dc.b	$60,$DC,$6C,$1C,$30,$CC,$CC,$FE
	dc.b	$38,$30,$32,$60,$0C,$18,$00,$00
	dc.b	$00,$7C,$66,$C0,$CC,$FC,$60,$CC
	dc.b	$66,$30,$0C,$78,$30,$FE,$CC,$CC
	dc.b	$66,$CC,$66,$78,$30,$CC,$CC,$FE
	dc.b	$38,$CC,$30,$30,$18,$30,$00,$C6
        
	ALIGN	256
; graphics data for 128 characters - line 4
	dc.b	$ff,$81,$FF,$FE,$FE,$FE,$7C,$3C
	dc.b	$C3,$42,$BD,$7D,$66,$30,$63,$E7
	dc.b	$FE,$FE,$18,$66,$7B,$6C,$00,$18
	dc.b	$18,$18,$FE,$FE,$C0,$FF,$7E,$7E
	dc.b	$00,$30,$00,$6C,$78,$18,$76,$00
	dc.b	$60,$18,$FF,$FC,$00,$FC,$00,$30
	dc.b	$DE,$30,$38,$38,$CC,$0C,$F8,$18
	dc.b	$78,$7C,$00,$00,$C0,$00,$0C,$18
	dc.b	$DE,$CC,$7C,$C0,$66,$78,$78,$C0
	dc.b	$FC,$30,$0C,$78,$60,$FE,$DE,$C6
	dc.b	$7C,$CC,$7C,$70,$30,$CC,$CC,$D6
	dc.b	$38,$78,$18,$60,$18,$18,$C6,$00
	dc.b	$00,$0C,$7C,$CC,$7C,$CC,$F0,$CC
	dc.b	$76,$30,$0C,$6C,$30,$FE,$CC,$CC
	dc.b	$66,$CC,$76,$C0,$30,$CC,$CC,$D6
	dc.b	$5C,$CC,$98,$E0,$00,$1C,$00,$6C
        
	ALIGN	256
; graphics data for 128 characters - line 3
	dc.b	$ff,$A5,$DB,$FE,$7C,$38,$38,$18
	dc.b	$E7,$66,$99,$0F,$66,$3F,$7F,$3C
	dc.b	$F8,$3E,$7E,$66,$DB,$38,$00,$7E
	dc.b	$7E,$18,$0C,$60,$C0,$66,$3C,$FF
	dc.b	$00,$78,$6C,$FE,$C0,$CC,$38,$C0
	dc.b	$60,$18,$3C,$30,$00,$00,$00,$18
	dc.b	$CE,$30,$0C,$0C,$6C,$F8,$C0,$0C
	dc.b	$CC,$CC,$30,$30,$60,$FC,$18,$0C
	dc.b	$DE,$CC,$66,$C0,$66,$68,$68,$C0
	dc.b	$CC,$30,$0C,$6C,$60,$FE,$F6,$C6
	dc.b	$66,$CC,$66,$E0,$30,$CC,$CC,$C6
	dc.b	$6C,$CC,$8C,$60,$30,$18,$6C,$00
	dc.b	$18,$78,$60,$78,$0C,$78,$60,$76
	dc.b	$6C,$70,$0C,$66,$30,$CC,$F8,$78
	dc.b	$DC,$76,$DC,$7C,$7C,$CC,$CC,$C6
	dc.b	$C6,$CC,$FC,$30,$18,$30,$00,$38

	ALIGN	256
; graphics data for 128 characters - line 2
	dc.b	$00,$81,$FF,$FE,$38,$7C,$10,$00
	dc.b	$FF,$3C,$C3,$07,$66,$33,$63,$5A
	dc.b	$E0,$0E,$3C,$66,$DB,$63,$00,$3C
	dc.b	$3C,$18,$18,$30,$00,$24,$18,$FF
	dc.b	$00,$78,$6C,$6C,$7C,$C6,$6C,$60
	dc.b	$30,$30,$66,$30,$00,$00,$00,$0C
	dc.b	$C6,$70,$CC,$CC,$3C,$C0,$60,$CC
	dc.b	$CC,$CC,$30,$30,$30,$00,$30,$CC
	dc.b	$C6,$78,$66,$66,$6C,$62,$62,$66
	dc.b	$CC,$30,$0C,$66,$60,$EE,$E6,$6C
	dc.b	$66,$CC,$66,$CC,$B4,$CC,$CC,$C6
	dc.b	$C6,$CC,$C6,$60,$60,$18,$38,$00
	dc.b	$30,$00,$60,$00,$0C,$00,$6C,$00
	dc.b	$60,$00,$00,$60,$30,$00,$00,$00
	dc.b	$00,$00,$00,$00,$30,$00,$00,$00
	dc.b	$00,$00,$00,$30,$18,$30,$DC,$10

	ALIGN	256
; graphics data for 128 characters - line 1
	dc.b	$00,$7E,$7E,$6C,$10,$38,$10,$00
	dc.b	$FF,$00,$FF,$0F,$3C,$3F,$7F,$99
	dc.b	$80,$02,$18,$66,$7F,$3E,$00,$18
	dc.b	$18,$18,$00,$00,$00,$00,$00,$00
	dc.b	$00,$30,$6C,$6C,$30,$00,$38,$60
	dc.b	$18,$60,$00,$00,$00,$00,$00,$06
	dc.b	$7C,$30,$78,$78,$1C,$FC,$38,$FC
	dc.b	$78,$78,$00,$00,$18,$00,$60,$78
	dc.b	$7C,$30,$FC,$3C,$F8,$FE,$FE,$3C
	dc.b	$CC,$78,$1E,$E6,$F0,$C6,$C6,$38
	dc.b	$FC,$78,$FC,$78,$FC,$CC,$CC,$C6
	dc.b	$C6,$CC,$FE,$78,$C0,$78,$10,$00
	dc.b	$30,$00,$E0,$00,$1C,$00,$38,$00
	dc.b	$E0,$30,$0C,$E0,$70,$00,$00,$00
	dc.b	$00,$00,$00,$00,$10,$00,$00,$00
	dc.b	$00,$00,$00,$1C,$18,$E0,$76,$00


; This routine waits for the vertical blanking period to start
        ORG     $9000
WaitVBLANK:
WaitVBoff:
	bit	MSTAT  
	bmi	WaitVBoff
WaitVBon:
	bit	MSTAT
	bpl	WaitVBon
	rts




; At this address the execution starts right after the encrypted signature
; check was passed successfully.
        ORG     $d000
START:
	sei			; disable interrupts
	cld
	lda	#$07		; lock the 7800 into MARIA mode
	sta	INPTCTRL
        lda	#$7f		; turn off DMA, since no output has
	sta	CTRL		; been set up yet
	ldx	#$ff		; set stack pointer to $01ff
	txs

        ; Program Startup inits
	stx	Latch		; no joystick movements yet
	lda	#$87
	sta	P0C2		; blue text
	lda	#$26
	sta	P0C1
	lda	#$36
	sta	P0C3
	lda	#$0F
	sta	BACKGRND
	sta	COLOR
	lda	#$00
	sta	INPTCTRL	; not really nessessary but the
	sta	OFFSET		; manual suggests it anyway
	lda	#$80		; the font data is located at $a000
	sta	CHBASE

; This loop copies the text data, DLL and DLs to the RAM at $1800
	ldx	#$00
CopyDLs:
	lda	$e000,x
	sta	$1800,x
	inx
	bne	CopyDLs
CopyDLLs:
	lda	$e200,x
	sta	$1A00,x
	inx
	bne	CopyDLLs


; Differences between the NTSC and PAL 7800 consoles' output:
;     NTSC     PAL
;      15       15     automatic VBLANK lines
;      25       33     output lines, that can't be seen on many TVs
;     192      228     actual display lines
;      26       32     output lines, that can't be seen on many TVs
;       4        4     automatic VBLANK lines
;
;     262      312     total number of lines per frame
;     243      293     total number of DMA output lines per frame
;      60       50     frames per second
;
; So to make a NTSC game run properly on a PAL console, you can simply
; set up 25 extra blank lines before and after the normal NTSC display.
; Also you would have to adjust anything that is timed by counting the
; number of frames, since PAL consoles do less frames per second than
; NTSC consoles.

	jsr	WaitVBLANK
WaitVBover:
	bit	MSTAT
	bmi	WaitVBover	;wait for the VBLANK to end

	lda	#$00		; prepare NTSC setup here
	sta	DPPL		; setup the pointers for the output
	lda	#$1A		; description (DLL) according to
	sta	DPPH		; the PAL/NTSC test to $1840/$184C
	jsr	WaitVBLANK	; wait until no DMA would happen
	lda	#%01001011	; then enable normal color output,
	sta	CTRL		; turn on DMA, set one byte wide
				; characters, make the border black
				; enable transparent output, set screen
				; mode to 320A or 320C

MainLoop:
	JSR	WaitVBLANK	; avoid any process-corruption
				; issues with DMA-interrupts
				; also, force calc's once per frame

	; Do all joystick calculations

	lda	SWCHB
	and	#$03    ; isolate select/reset bits
	eor	#$03
	beq	No_Reset

	; Reset/Select - resets colors to $00
	LDA	#$00
	STA	COLOR
	sta	BACKGRND
	STA	LEFTCOLOR
	STA	RIGHTCOLOR
	JMP	MainLoop
No_Reset
	LDA	SWCHA
	BMI	NotRt
	LDA	Latch
	BPL	NotRt
	; right - increase high nibble of color
WrapDown
	CLC
	LDA	COLOR
	ADC	#$10
	STA	COLOR
	sta	BACKGRND
	JMP	NotUp
NotRt
	ROL
	BMI	NotLeft
	LDA	Latch
	ROL
	BPL	NotLeft
	; left - decrease high nibble of color
WrapUp
	SEC
	LDA	COLOR
	SBC	#$10
	STA	COLOR
	sta	BACKGRND
	JMP	NotUp
NotLeft
	ROL
	BMI	NotDown
	LDA	Latch
	ROL
	ROL
	BPL	NotDown
	; down - decrease low nibble of color
	DEC	COLOR
	LDA	COLOR
	sta	BACKGRND
	AND	#$0F
	CMP	#$0F
	BEQ	WrapDown
	JMP	NotUp
NotDown
	ROL
	BMI	NotUp
	LDA	Latch
	ROL
	ROL
	ROL
	BPL	NotUp
	; up - increase low nibble of color
	INC	COLOR
	LDA	COLOR
	sta	BACKGRND
	AND	#$0F
	BEQ	WrapUp
NotUp
	LDA	SWCHA
	AND	#$F0
	STA	Latch
	lda	COLOR
	AND	#$0F
	CMP	#$0A
	BMI	NotLetter1
	CLC
	ADC	#$07
NotLetter1
	ADC	#$30
	STA	RIGHTCOLOR
	LDA	COLOR
	CLC
	AND	#$F0
	ROR
	ROR
	ROR
	ROR
	CMP	#$0A
	BMI	NotLetter2
	CLC
	ADC	#$07
NotLetter2
	ADC	#$30
	STA	LEFTCOLOR
	jmp	MainLoop



; At this address the execution will continue after a BRK instruction.
	ORG	$D4A5
BRKroutine:
	rti



; Pointers to the graphic data are here - $1800 in RAM

	ORG	$e000

	.byte	" "			; $1800 [1]
	.byte	"Programmed by"		; $1801 [13]
	.byte	"John K. Harvey"	; $180E [14]
	.byte	"Special Thanks to"	; $181C [17]
	.byte	"Eckhard Stolberg"	; $182D [16]
	.byte	"COLOR = $"		; $183D [9]

; The DL starts here - $1880 in RAM

	ORG	$e080

	.byte	$00,$60,$18,$1f,$00	; DL for GRAPHICS_SPACE
	.byte	$00,$00
	Align	8			; $1888
	.byte	$01,$60,$18,$13,50	; DL for "Programmed by"
	.byte	$00,$00
	Align	8			; $1890
	.byte	$0E,$60,$18,$12,50	; DL for "John K. Harvey"
	.byte	$00,$00
	Align	8			; $1898
	.byte	$1C,$60,$18,$0F,50	; DL for "Special Thanks To"
	.byte	$00,$00
	Align	8			; $18A0
	.byte	$2D,$60,$18,$10,50	; DL for "Eckhard Stolberg"
	.byte	$00,$00
	Align	8			; $18A8
	.byte	$3D,$60,$18,$17,50	; DL for "COLOR = $"

	; DL for left nibble hex Color
	.byte	<LEFTCOLOR, $60,>LEFTCOLOR, $1f,85
	; DL for right nibble hex Color
	.byte	<RIGHTCOLOR,$60,>RIGHTCOLOR,$1f,89
	.byte	$00,$00


; The DLL starts here - $1A00 in RAM

	ORG	$e200

	.byte	$00,$18,$80	; 25 blank lines that can't be seen
	.byte	$07,$18,$80	; on most NTSC TVs anyway
	.byte	$07,$18,$80

	.byte	$87,$18,$80	; if the highest bit of the first byte
				; in a DLL entry is set, an interrupt
				; will occur after the DMA for the
				; last line in this block of scanlines
				; has ended


	; Total = 192 scanlines
	.byte	$07,$18,$80	; [8] blank
	.byte	$07,$18,$80	; [16] blank
	.byte	$07,$18,$80	; [24] blank
	.byte	$07,$18,$80	; [32] blank
	.byte	$07,$18,$88	; [40] DL for "Programmed by"
	.byte	$07,$18,$90	; [48] DL for "John K. Harvey"
	.byte	$07,$18,$80	; [56] blank
	.byte	$07,$18,$80	; [64] blank
	.byte	$07,$18,$80	; [72] blank
	.byte	$07,$18,$80	; [80] blank
	.byte	$07,$18,$80	; [88] blank
	.byte	$07,$18,$80	; [96] blank
	.byte	$07,$18,$80	; [104] blank
	.byte	$07,$18,$80	; [112] blank
	.byte	$07,$18,$80	; [120] blank
	.byte	$07,$18,$A8	; [128] DL for Color
	.byte	$07,$18,$80	; [136] blank
	.byte	$07,$18,$80	; [144] blank
	.byte	$07,$18,$98	; [152] DL for "Special Thanks to"
	.byte	$07,$18,$A0	; [160] DL for "Eckhard Stolberg"
	.byte	$07,$18,$80	; [168] blank
	.byte	$07,$18,$80	; [176] blank
	.byte	$07,$18,$80	; [184] blank
	.byte	$07,$18,$80	; [192] blank

	.byte	$07,$18,$80	; The DMA keeps doing another 26 lines
	.byte	$07,$18,$80	; which can't be seen on most NTSC
	.byte	$07,$18,$80	; TVs, so they are set to be blank
	.byte	$01,$18,$80


; At this address the execution will continue after an interrupt has
; occured. Here we change the horizontal position for the two lines of
; text to shift them continuously over the screen. In this example code
; the interrupt occurs in the scanline before the PAL/NTSC text starts
; displaying in every frame.
	ORG	$EB1C
INTERRUPT:
	rti


; Startup
	ORG	$EB49
	JMP	$D000

	ORG	$f000
	incbin TOMCAT4K.BIN
